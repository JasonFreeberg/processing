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
	corpus = ""
	for paragraph in paragraphs:
		text = str(paragraph.get_text())
		noCites = citations.sub(repl="", string=text)
		corpus += noCites

	nWords = len(corpus.split())
	nChar = len(corpus)

	return corpus, nWords, nChar


def getLinksFromURL(aURL):
	validLinks = re.compile(r"(?=(^/wiki))(?!.*(:))(?!.*(disambiguation))(?!.*(Main_Page))")

	html = urlopen(aURL).read()
	soup = BeautifulSoup(html, "lxml")
	links = soup.findAll("a")
	returnLinks = []  # list of extensions to return

	for link in links:
		href = str(link.get("href"))

		if validLinks.match(href):
			returnLinks.append(href)

	return list(set(returnLinks))


def getArticles(aURL, layer, extensionsSoFar):
	baseURL = "https://en.wikipedia.org"

	if layer <= 1 and len(extensionsSoFar) < 50000:
		links = getLinksFromURL(aURL)
		for link in links:
			if link not in extensionsSoFar:
				extensionsSoFar.append(link)
				#print(len(extensionsSoFar), "extensions so far. Currently at layer", layer)
				getArticles(baseURL + link, layer + 1, extensionsSoFar, layerCount)
	else: # stop recursion
		pass

if __name__ == "__main__":
	#idk = getLinksFromURL(baseURL + "/wiki/Philosophy")
	lotsOfFuckingArticles = []
	layerCount = []
	getArticles(baseURL + "/wiki/Donald_Trump", 0, lotsOfFuckingArticles)

	lotsOfFuckingArticles.sort()
	print("-----------------------------------------------------", "\n \n \n \n\n\n")

	print("Scraped", len(lotsOfFuckingArticles), "articles.")
	print("Max layer =", max(layerCount))

	for i in range(0, len(lotsOfFuckingArticles)):
		print(lotsOfFuckingArticles[i], "\t\t\t\t\t\t", layerCount[i])



