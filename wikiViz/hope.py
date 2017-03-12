import csv
import sys
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.decomposition import PCA
from sklearn.model_selection import KFold
import pandas as pd
import re
from math import floor

# The text fields are HUGE, max out the buffer
csv.field_size_limit(sys.maxsize)

noNumbers = re.compile(r".*[0-9].*")

file = open("hope.csv", "r")
csv_ = csv.reader(file, delimiter=",")
data = pd.DataFrame({
                      "title": [],
                      "extension": [],
                      "text": [],
                      "layer": [],
                      "parent": []
                    })

indx = 0
stop = 50
for row in csv_:
    if indx != 0:

      text = row[7].split()
      before = len(text)
      text = {elem for elem in text if not noNumbers.match(elem)}
      after = len(text)

      newText = text
      """
      c = 0
      newText = set()
      for elem in text:
        if c < after/12:
          newText.add(elem)
        c += 1
      """
      #print(before, "-->", after, "-->", len(newText))
      newText = " ".join(newText)

      new = pd.DataFrame({
                "title": [row[9]],
                "extension": [row[6]],
                "text": [newText],
                "layer": [row[8]],
                "parent": [row[2]]
              })
      data = data.append(new)
    indx += 1
    #if indx > stop:
    #  break

before = data.shape[0]
data.drop_duplicates(subset="title", keep="first", inplace=True)
after = data.shape[0]
print("Dropped", before-after, "duplicates. Now have", after, "rows.")
print("Index hit", indx)
print(data.head())


vectorizer = TfidfVectorizer(stop_words="english", lowercase=True)
pca = PCA(n_components=8)
kfold = KFold(n_splits = 50)

# Vectorize the text
tfidf = vectorizer.fit_transform(data.text).toarray()
tfidfDF = pd.DataFrame(tfidf)
print("tfidf matrix made.")

# Join data
print("Nrows in data:", data.shape[0])
print("Nrows in tfidf:", tfidf.shape[0])
data.reset_index(drop=True, inplace=True)
tfidfDF.reset_index(drop=True, inplace=True)

# Perform PCA
print("Starting PCA")

blah = list()
for _, train_ind in kfold.split(data):
  print("folded")
  prComp = pd.DataFrame(pca.fit_transform(X = tfidfDF.ix[train_ind]))
  ass = data[["title", "layer", "parent"]].ix[train_ind]
  ass.reset_index(drop=True, inplace=True)
  prComp.reset_index(drop=True,inplace=True)
  newestData = pd.concat([ass, prComp], axis=1, ignore_index=True, join="outer")
  blah.append(newestData)

done = blah[0]
for elem in blah[1:]:
  done = pd.concat([done, elem], axis = 0, ignore_index = True)

# Write to file and close connection to old file
print("Writing file.")
done.to_csv("wikiPCA.csv", sep=",", index=False)
file.close()

print("End.")