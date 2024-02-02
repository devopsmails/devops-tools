01.HCL Vault installation on AWS Ec2 ububntu:
----------
Server config:
----------
```
AWS AMI: UBUNTU: 8200 port sg
Basic free config: t3 micro, 
mem: 8
```
```
O-Doc: https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install
```
Update the package manager and install GPG and wget.
```
sudo apt update && sudo apt install gpg wget -y
```
Download the keyring
```
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
```
Verify the keyring

```
gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --fingerprint
```

Add the HashiCorp repository.
```
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```
Install Vault.
```
sudo apt update && sudo apt install vault -y
```

verify
```
vault
```

02.Starting vault dev server:
---------------
Step 1 : CLI Command for starting the server 
```
vault server -dev -dev-listen-address="0.0.0.0:8200"

output:
------
Api Address: http://0.0.0.0:8200
Storage: inmem
Unseal Key: GsygUy7GSg5LXmh5Ux1eZe02Cb96oI8H/rTLXfBAv1U=
Root Token: hvs.OaGgvDtehkxsUrLbIcQ2OwO5
```
On a dubplicate tab of the same server:

Step 2 : Set VAULT_ADDR by exporting to environment variable 
```
export VAULT_ADDR='http://0.0.0.0:8200'
```
No need of step 3
/####.Step 3 : Set Root Token by exporting to environment variable 
```
export VAULT_TOKEN="hvs.OaGgvDtehkxsUrLbIcQ2OwO5"(#root token)\.####
```

Step 4 : Verify the status of vault server by running the command 
```
vault status
```

webbroswer:

```
vault pub IP:8200 port enabled
vault web:
type: Token
token: hvs.OaGgvDtehkxsUrLbIcQ2OwO5(#Root token) >> Vault UI Dash board
```
