# Jason Freeberg
# MAT 259A
# Join .csv files and call iTunes API to get data on albums

import pandas as pd
import requests
import json
import re


# Class for accessing iTunes API
class pyTunes():
    def __init__(self, mediaType, entity):
        self.media = mediaType
        self.entity = entity
        self.data = None
        self.URL = "https://itunes.apple.com/search?" + "media=" + self.media + "&entity=" + self.entity

    def search(self, term):
        newTerm = term.lower().replace(' ', '+')
        request = requests.get(self.URL + "&term=" + newTerm)
        self.data = json.loads(request.text)

    def getField(self, field):
        try:
            return self.data["results"][0][field]
        except IndexError:
            print("No results for {0}, returned empty string.".format(field))
            return ''

    # Prases copyright from iTunes API
    def parseCopyRight(self, theString):
        try:
            return re.search(r"[0-9]{4}", theString).group(0)
        except AttributeError:
            print("No copyright date found, returned empty string.")
            return ''


# Main body
def main():
    musicAlbums = pyTunes(mediaType="music", entity="album")

    transactions = pd.read_csv("data/transactions.csv")
    popularity = pd.read_csv("data/popularity.csv")

    print(transactions)

"""
musicAlbums.search("lemonade")
artistName = musicAlbums.getField("artistName")
genre = musicAlbums.getField("primaryGenreName")
artWork = musicAlbums.getField("artworkUrl100")
copyRight = musicAlbums.getField("copyright")

print(artistName, genre, artWork, copyRight, parseCopyRight(copyRight))
print("------------------------")
print(json.dumps(musicAlbums.data["results"][0], indent=2))
"""

# Execute main program
if __name__ == "__main__":
    main()
