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
            print("self.data is of type", str(type(self.data)), "returned empty string.")
            return ''

# Parses copyright from iTunes API
def parseCopyRight(theString):
    try:
        return re.search(r"[0-9]{4}", theString).group(0)
    except AttributeError:
        print("No copyright date found, returned empty string.")
        return ''

musicAlbums = pyTunes(mediaType="music", entity="album")

musicAlbums.search("kanye west")
print(musicAlbums.URL)
artistName = musicAlbums.getField("artistName")
genre = musicAlbums.getField("primaryGenreName")
artWork = musicAlbums.getField("artworkUrl100")
copyRight = musicAlbums.getField("copyright")

print(artistName, genre, artWork, copyRight, parseCopyRight(copyRight))
print("------------------------")
print(json.dumps(musicAlbums.data["results"][0], indent=2))

