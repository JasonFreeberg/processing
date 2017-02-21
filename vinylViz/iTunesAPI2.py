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
        self.media = mediaType
        self.entity = entity
        self.data = None
        self.URL = "https://itunes.apple.com/search?" + "media=" + self.media + "&entity=" + self.entity
        self.noData = 0

    def search(self, term):
        newTerm = term.lower().replace(' ', '+')
        try:
            request = requests.get(self.URL + "&term=" + newTerm)
            self.data = json.loads(request.text)
        except json.JSONDecodeError:
            print("No response, data = None.")
            self.data = None

    def getField(self, field):
        if self.data is None:
            return ''
        else:
            try:
                return self.data["results"][0][field]
            except IndexError:
                print("No results for {0}, returned empty string.".format(field))
                self.noData += 1
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