o-doc:   
https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-dev-server  
Starting vault dev server:  
---------------
Step 1 : CLI Command for starting the devserver ###not for productions####
```
vault server -dev -dev-listen-address="0.0.0.0:8200"

output:
------
Api Address: http://0.0.0.0:8200
Storage: inmem
Unseal Key: lMoWHiX+F4T2CGouKBxRedj4x12/w0sCWTQuvSTQJwc=
Root Token: hvs.iu7spRhiajSuKVhMLKNpIOki
```
On a dubplicate tab of the same server:

Step 2 : Set VAULT_ADDR by exporting to environment variable 
```
 export VAULT_ADDR='http://0.0.0.0:8200'
```
save Unseal key:
```
echo "lMoWHiX+F4T2CGouKBxRedj4x12/w0sCWTQuvSTQJwc=" > unseal.key
```

####.Step 3 : Set Root Token by exporting to environment variable 
```
export VAULT_DEV_ROOT_TOKEN_ID="hvs.iu7spRhiajSuKVhMLKNpIOki"(#root token)\.####
```

Step 4 : Verify the status of vault server by running the command 
```
vault status
```

