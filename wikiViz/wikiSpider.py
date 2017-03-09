# 
# 
# 
# 


import scrapy
import re
import pandas as pd
from bs4 import BeautifulSoup
from csv import writer

class wikiSpider(scrapy.Spider):
	name = "wiki"
	base = "http://en.wikipedia.org"
	start_urls = ["http://en.wikipedia.org/wiki/Philosophy"]
	extensionsSoFar = set()

	# Main parse function
	def parse(self, response, level=0, parent="None"):

		# Coerce to soup and parse
		soup = BeautifulSoup(response, "lxml")
		links = self.getLinks(soup)
		title = self.getTitle(soup)
		text = self.getText(soup)

		# Add to set of pages and yield
		self.extensionsSoFar.add(link)
		yield {
		        "title": title,
		        "parent": parent,
		        "level": level,
		        "text": text
		      }

		if level < 1:
			for link in links - self.extensionsSoFar:
				yield from parse(self.base + link, level + 1, title)

	# Grab title from soup
	def getTitle(self, soup):
		titleJunk = re.compile(r" - Wikipedia")  # removes " - Wikipedia"

		title = soup.title.get_text()
		title = titleJunk.sub(repl="", string=title)
		return title

	# Get set of links
	def getLinks(self, soup):
		validLinks = re.compile(r"(?=(^/wiki))(?!.*(:))(?!.*(disambiguation))(?!.*(Main_Page))")
		links = soup.findAll("a")
		returnLinks = set()  # set of extensions to return

		paragraphs = soup.findAll("p")
		for p in paragraphs:
		    for a in p.findAll("a"):
		        href = a.get("href") 
		        if validLinks.match(href):
		            returnLinks.add(href)

	# Get cleaned text
	def getText(self, soup):
		citations = re.compile(r"\[\d+\]")  # Removes citations

		paragraphs = soup.findAll("p")
		parsedText = ""
		for paragraph in paragraphs:
			text = str(paragraph.get_text())
			noCites = citations.sub(repl="", string=text)
			parsedText += noCites

		return parsedText
