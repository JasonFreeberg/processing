# Jason Freeberg
# MAT 259A -- Winter 2017
# Feb. 25, 2017

# Scraping data from Wikipedia articles
# 
# 
# 

from bs4 import BeautifulSoup
from urllib.request import urlopen
import re

# Some constants
baseURL = "https://en.wikipedia.org"
URL = "https://en.wikipedia.org/wiki/Philosophy"
wikiRe = re.compile(r"(?=(^/wiki))(?!.*(:))")

# Grab main text and links
html = urlopen(URL).read()
soup = BeautifulSoup(html, "lxml")
paragraphs = soup.findAll("p")
links = soup.findAll("a")
images = soup.findAll("img")
sideTable = soup.find("table", attrs = {"class": "vertical-navbox"})

#     Get info on paragraphs     #
##################################
citations = re.compile(r"\[\d+\]")
for paragraph in paragraphs[:0]:

	text = paragraph.get_text()
	citations.sub(repl="", string=text)

###################################

# Get links that match regex
"""
extensions = []
for link in links:
	href = str(link.get("href"))
	title = str(link.get_text())

	if wikiRe.match(href):
		extensions.append(href)

extensions = list(set(extensions))
extensions.sort()

for extension in extensions:
	print(extension)

# Get the image in sidebar
tableImage = sideTable.find("img").get("src")
print(sideTable.find("img"))
print(tableImage)
"""

