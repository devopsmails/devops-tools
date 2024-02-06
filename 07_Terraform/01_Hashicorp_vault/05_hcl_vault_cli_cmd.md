Key-value Secrets:
-----------
```
vault kv put secret/dev username=dev-gabby  
    - kv = key value
    - put = adding secrets
    - secret/dev = storage path in vault
    - username= key
    - dev-gabby=value

vault kv put secret/dev username=dev-gabby-1 password=kjhdfjka
    - can add multiple key values

vault kv get secret/dev
    - list key values

vault kv get -field=username secret/dev
    - Shows only value for username

sudo apt  install jq -y 
    - to get Json format values

vault kv get -format=json secret/dev | jq -r .data.data.username
    - shows the value if fromat is in Json

vault kv delete secret/dev/username
    - deletes the key username


```
