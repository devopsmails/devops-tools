What is Vault Secret Engnine?
--------
```
Secret Engine manage how secrets are stored, generated, accessed, and encrypted. Each engine caters to specific types of secrets and functionalities.
By Default vault KV secret engine will be enabled
```
Types of Secret Engines?
```
Generic:
    1.KV
    2.SSH
    3.TOTP
    4.LDAP
    5.KUBERNETES
Cloud: AWS(IAM Access key)
Infra: Data bases, Consul
```

vault secrets enable -path=pprod kv
    - Creates new path for creating key values

vault secrets list
    - lists the secrets path, secret engine types, Accessors, Descriptions
e
vault kv list secret/pprod
    - list all the key values in the path secret/pprod

vault secrets disable secret/dev
    - ###deletes the secret engine in the path secret/dev permanently###(backup first)

