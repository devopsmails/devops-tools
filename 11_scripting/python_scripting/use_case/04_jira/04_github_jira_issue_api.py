# This code sample uses the 'requests' library:
# http://docs.python-requests.org
import requests
from requests.auth import HTTPBasicAuth
import json
from flask import Flask

app = Flask(__name__)

# Define a route that handles GET requests
@app.route('/createJira', methods=['POST', 'GET'])
def createJira():
    URL = "https://github.com/devopsmails/python.git"
    git_hub_repo_url = "https://api.github.com/repos/devopsmails/python/issues/comments"

    response = requests.get(git_hub_repo_url)
    comments = response.json()
    comment_value = comment['body']
    for comment in comments:
        comment_author = comment["user"]["login"]
        comment_value = comment['body']
        
        if comment_value.lower() == "/jira":
            
            url = "https://devopsmails1.atlassian.net/rest/api/3/issue"

            API_TOKEN = "ATATT3xFfGF0124S190nTOnRPvCoEgV3aoJPau0Pun-PLGFfjdcbzndsBuExfPPVzPydl95cE55hU58-7V66xoYMdVHVHw0cDf-gT5obtPDzD14eTaRpxU_uBQvIbx_UuFSLQvqLmtKVtmCNMS_tYOGtnQW0ZtEHgzgGtrSmjbHVHRghiGEK69Y=469EE366"

            auth = HTTPBasicAuth("devopsmails1@gmail.com", API_TOKEN)
            
            headers = {
                "Accept": "application/json",
                "Content-Type": "application/json"
            }

            payload = json.dumps({
                "fields": {
                    "description": {
                        "content": [
                            {
                                "content": [
                                    {
                                        "text": "Order entry fails when selecting supplier.",
                                        "type": "text"
                                    }
                                ],
                                "type": "paragraph"
                            }
                        ],
                        "type": "doc",
                        "version": 1
                    },
                    "project": {
                        "key": "DEV"
                    },
                    "issuetype": {
                        "id": "10007"
                    },
                    "summary": "Main order flow broken",
                },
                "update": {}
            })

            response = requests.request(
                "POST",
                url,
                data=payload,
                headers=headers,
                auth=auth
            )

            return json.dumps(json.loads(response.text), sort_keys=True, indent=4, separators=(",", ": "))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
