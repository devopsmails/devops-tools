# This code sample uses the 'requests' library:
# http://docs.python-requests.org
import requests
from requests.auth import HTTPBasicAuth
import json

url = "https://devopsmails1.atlassian.net/rest/api/3/project"

API_TOKEN = "ATATT3xFfGF0rnSVttS6358hqP_k5cUkdXq40qX4pDw--oesqmerQOcemiSB01JwNwP1q6J3pnTc6z5BuwAb04yR2NH3DiBRShr49iTRxy6zUcYRs_xVolPt8tJ5dPAWPdh2X82GbPal89dGTrOQI_uSHOGntc2sTsZdyfUz2wesiLMn1tQntLk=C1B836B9"

auth = HTTPBasicAuth("devopsmails1@gmail.com", API_TOKEN)

headers = {
  "Accept": "application/json"
}

response = requests.request(
   "GET",
   url,
   headers=headers,
   auth=auth
)
output = json.loads(response.text)

for item in output:
  names = print(item["name"])
  print(names)
