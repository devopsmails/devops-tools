HCL Vault O-Docs:

```
https://developer.hashicorp.com/vault/tutorials/getting-started/getting-started-install
```

What is Hashi Corp Vault ?
```
Open-source secrets management platform by HashiCorp
    > Secrets written to vaults are encrypted then written to backend storage(in-mem - dev, disk - prod)

    > Backend storage can't  view the secrets values as doesn't have means to decrypt the secrets without vaults
    > creating secrets via cli can be stored in logs
    > Best to use ""files"


```


Features:
```
Centralized storage: 
    Securely store sensitive data like passwords, API keys, and other secrets.
Dynamic secrets: 
    Generate passwords, tokens, and other secrets on-demand.
Access control: 
    Granularly control who can access what secrets based on policies and roles.
Auditing and logging: 
    Track access and changes to secrets for accountability.
Multiple secret engines: 
    Integrates with various tools and platforms to manage diverse secrets.
Multi-cloud and hybrid deployments: 
    Works across cloud providers and on-premises environments.
```

Uses:
```
Securing applications and infrastructure
Managing secrets for CI/CD pipelines
Enabling cloud-native security
Protecting DevOps workflows
Enforcing compliance with security regulations
```


