# Jason Freeberg
# MAT 259A -- Winter 2017
# Feb. 25, 2017

# Scraping data from Wikipedia articles
# 
# 
# 

from bs4 import BeautifulSoup
from urllib.request import urlopen
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import PCA
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
	parseImagesURL = re.compile(r"")
	images = soup.findAll("img")
	nImages = len(images)
	try:
		sideTable = soup.find("table", attrs = {"class": "vertical-navbox"})
		tableImage = sideTable.find("img").get("src")
	except AttributeError:
		print("No image for article:", getTitle(soup))
		tableImage = ""

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
	returnLinks = set()  # set of extensions to return

	for link in links:
		href = str(link.get("href"))

		if validLinks.match(href):
			returnLinks.add(href)

	return returnLinks


def getArticles(anExtension, level=0, extensionsSoFar=set(), parent="None"):

	# Parse the HTML, make soup object
	html = urlopen("https://en.wikipedia.org" + anExtension).read()
	soup = BeautifulSoup(html, "lxml")
	links = getLinks(soup)

	yield {"title": [getTitle(soup)],
		   "extension": [anExtension],
		   "imgURL": [parseImages(soup)[0]],
		   "nChar": [parseText(soup)[2]],
		   "nWords": [parseText(soup)[1]],
		   "nImg": [parseImages(soup)[1]],
	       "nLinks": [len(links)],
	       "level": [level],
	       "text": [parseText(soup)[0]]
		  }

	# If at level 0, 1
	if level < 1:
		for link in links - extensionsSoFar:
			extensionsSoFar.add(link)
			yield from getArticles(link, level + 1, extensionsSoFar, getTitle(soup))
	"""
	else: # at level 2, parse and return
		yield {
				"title": [getTitle(soup)],
				"extension": [anExtension],
				"imgURL": [parseImages(soup)[0]],
			    "nChar": [parseText(soup)[2]],
			    "nWords": [parseText(soup)[1]],
			    "nImg": [parseImages(soup)[1]],
			    "nLinks": [len(links)],
			    "level": [level],
			    "text": [parseText(soup)[0]]
			  }
	"""
if __name__ == "__main__":

	vectorizer = TfidfVectorizer(stop_words="English", lowercase=True)

	# Starting values
	start = "/wiki/Philosophy"
	parent = "none"

	# Accumulator
	data = pd.DataFrame({
			"title": [],
			"extension": [],
			"imgURL": [],
		    "nChar": [],
		    "nWords": [],
		    "nImg": [],
		    "nLinks": [],
		    "level": [],
		    "text": []
		    })

	try:
		for elem in getArticles(start, parent="None"):
			elem = pd.DataFrame(elem)
			data = data.append(elem)
	except KeyboardInterrupt:
		pass

	dim = data.shape
	print("Rows:", dim[0], "Columns:", dim[1])
	print(data.head())

	tfidf = vectorizer.fit_transform()
	




