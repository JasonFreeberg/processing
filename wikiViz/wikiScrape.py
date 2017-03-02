# Jason Freeberg
# MAT 259A -- Winter 2017
# Feb. 25, 2017

# Scraping data from Wikipedia articles
# 
# 
# 

from bs4 import BeautifulSoup
from urllib.request import urlopen
from time import sleep
import pandas as pd
import re

# Some constants
URL = "https://en.wikipedia.org/wiki/Philosophy"
baseURL = "https://en.wikipedia.org"
# Grab main text and links
html = urlopen(URL).read()
soup = BeautifulSoup(html, "lxml")

# Article title
def getTitle(soup):
	titleJunk = re.compile(r" - Wikipedia")  # removes " - Wikipedia"

	title = soup.title.get_text()
	title = titleJunk.sub(repl="", string=title)
	return title

# Image for article
def parseImages(soup):
	parseImagesURL = re.complie(r"")
	images = soup.findAll("img")
	sideTable = soup.find("table", attrs = {"class": "vertical-navbox"})
	tableImage = sideTable.find("img").get("src")
	nImages = len(images)

	return tableImage, nImages

# Main body text
def parseText(soup):
	citations = re.compile(r"\[\d+\]")  # Removes citations

	paragraphs = soup.findAll("p")
	parsedText = ""
	for paragraph in paragraphs:
		text = str(paragraph.get_text())
		noCites = citations.sub(repl="", string=text)
		parsedText += noCites

	nWords = len(parsedText.split())
	nChar = len(parsedText)

	return parsedText, nWords, nChar


def getLinks(soup):
	validLinks = re.compile(r"(?=(^/wiki))(?!.*(:))(?!.*(disambiguation))(?!.*(Main_Page))")

	links = soup.findAll("a")
	returnLinks = []  # list of extensions to return

	for link in links:
		href = str(link.get("href"))

		if validLinks.match(href):
			returnLinks.append(href)

	return list(set(returnLinks))


def getArticles(anExtension, layer, dataFrame):
	baseURL = "https://en.wikipedia.org"

	if layer <= 1 and len(extensionsSoFar) < 50000:

		html = urlopen(baseURL + anExtension).read()
		soup = BeautifulSoup(html, "lxml")
		
		links = pd.DataFrame({"extension": getLinks(soup)})
		dataFrame = dataFrame.merge([dataFrame, links], on="extension", how="outer")

		newData = pd.DataFrame({
			"extension": [anExtension],
			"title": [getTitle(soup)],
			"imgURL": [parseImages(soup)[0]],
		    "nChar": [parseText(soup)[2]],
		    "nWords": [parseText(soup)[1]],
		    "nImg": [parseImages(soup)[1]],
		    "nLinks": [len(links)],
		    "text": [parseText(soup)[0]]
		})

		dataFrame = dataFrame.merge([dataFrame, newData], on="extension", how="outer")

		for link in dataframe.links:
			if link not in extensionsSoFar:
				extensionsSoFar.append(link)

				print(len(extensionsSoFar), "extensions so far. Currently at layer", layer)
				getArticles(link, layer + 1, dataFrame)
	else: # stop recursion
		pass

if __name__ == "__main__":

	start = "/wiki/Philosophy"

	data = {
			"title": [],
			"extension": [],
			"imgURL": [],
		    "nChar": [],
		    "nWords": [],
		    "nImg": [],
		    "nLinks": [],
		    "text": []
		    }

	frame = pd.DataFrame(data)




