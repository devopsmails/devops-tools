import requests

URL = "https://github.com/devopsmails/python.git"

git_hub_repo_url = "https://api.github.com/repos/devopsmails/python/issues/comments"
/repos/{owner}/{repo}/issues/comments/{comment_id}
response = requests.get(git_hub_repo_url)
comments = response.json()

for comment in comments:
    #comment_author = comment["user"]["login"]
    comment_value = comment['body']
    print(comment_value)

    if comment_value == "/jira":
        print("yes")
