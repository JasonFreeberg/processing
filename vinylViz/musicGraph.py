# 
# 
# 

import pandas as pd
import requests
import json
import re
from time import sleep

key = "gjEKRdPpZOYqnXKqdfnT"
secret = "GNiQeSghgayDjFkmvKoPsXKuNBUHWGaK"
term = "Nirvana"
URL = "https://api.discogs.com/database/search?q=Nirvana&key=foo123&secret=bar456"
