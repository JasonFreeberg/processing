
import pandas as pd
from bs4 import BeautifulSoup
from urllib.request import urlopen
import json
import re
from time import sleep

URL = "https://en.wikipedia.org/wiki/Michael_Jackson_albums_discography"
page = urlopen(URL).read()
soup = BeautifulSoup(page, "lxml")
tables = soup.find_all("table", attrs = {"class": "wikitable plainrowheaders"})

titles = []
for table in tables[0:2]:
	for header in table.find_all("th", attrs = {"scope": "row"}):
		anchor = header.find('a')
		if anchor is None:
			continue
		else:
			print(anchor.contents[0])
			titles.append(anchor.contents[0].lower())

print(titles)

file = open('albumTitles.txt', 'w')

for title in titles:
	file.write("\"" + title + "\"," )

file.close()
