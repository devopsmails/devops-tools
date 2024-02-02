import requests

url = f'https://api.github.com/repos/kubernetes/kubernetes/pulls'

response = requests.get(url)
if response.status_code == 200: 
    pull_requests = response.json()


    pr_creators = {}

    for pull in pull_requests:
        creator = pull["user"]["login"]
        creator_id = pull["id"]
        if creator in pr_creators:
            pr_creators[creator] +=1
        else:
            pr_creators[creator] =1

    print("\n{:<20} {:<20} {:<20}".format("username", "creator_id", "No_of_pull_requests\n"))

    for creator, count in pr_creators.items():
        print("{:<20} {:<20} {:<20}".format(creator, creator_id, count))



# username             creator_id           No_of_pull_requests

# AxeZhan              1650391827           2                   
# utam0k               1650391827           1                   
# ardaguclu            1650391827           1                   
# Songjoy              1650391827           1                   
# carlory              1650391827           2     
