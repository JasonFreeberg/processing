# Jason Freeberg
# MAT 259A
# Join .csv files and call iTunes API to get data on albums


import pandas as pd
import requests
import json
import re
from time import sleep


# Class for accessing iTunes API
class pyTunes():
    def __init__(self, mediaType, entity):
        self.media = mediaType  # movies, music, books,  etc.
        self.entity = entity    # album, song, artist, etc.
        self.data = None        # hold JSON
        self.noData = 0         # count times no data returned
        self.term = ''          # the searched string
        self.URL = "https://itunes.apple.com/search?" + "media=" + self.media + "&entity=" + self.entity

    def search(self, term):
        self.term = term.lower().replace(' ', '+')
        try:
            request = requests.get(self.URL + "&term=" + self.term)
            self.data = json.loads(request.text)
        except json.JSONDecodeError:
            print("No response for {0}".format(term))
            self.data = None

    def getField(self, field):
        try:
            return self.data["results"][0][field]
        except IndexError:
            print("No {0} field for entity {1}".format(field, self.term))
            self.noData += 1
            return ''
        except TypeError:
            print("self.data is of type", type(self.data), "returned empty string.")
            return ''


# Parses copyright from iTunes API
def parseCopyRight(theString):
    try:
        return re.search(r"[0-9]{4}", theString).group(0)
    except AttributeError:
        print("No copyright date found, returned empty string.")
        return ''


# Main body
def main():

    # Going to search stricly for music albums
    musicAlbums = pyTunes(mediaType="music", entity="album")

    transactions = pd.read_csv("data/transactions.csv")
    popularity = pd.read_csv("data/popularity.csv")

    uniqueTitles = set(transactions.ix[:, "title"])

    #print(transactions.head())
    #print(popularity.head())
    print("There are", len(uniqueTitles), "unique titles.")

    iTunesData = {
        "title": uniqueTitles,
        "artist": [],
        "genre": [],
        "artURL": [],
        "year": []
    }

    for title in iTunesData["title"]:

        # Call API
        musicAlbums.search(title)

        # Append to dict values
        iTunesData["artist"].append(musicAlbums.getField("artistName"))
        iTunesData["genre"].append(musicAlbums.getField("primaryGenreName"))
        iTunesData["artURL"].append(musicAlbums.getField("artworkUrl100"))
        iTunesData["artURL"].append(parseCopyRight(musicAlbums.getField("copyright")))

        # So I don't piss off Apple
        sleep(0.5)

    iTunesData = pd.DataFrame(iTunesData)
    print(iTunesData.head())

# Execute main function
if __name__ == "__main__":
    main()