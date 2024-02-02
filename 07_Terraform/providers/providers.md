What is Providers ?
------------------

A provider in Terraform is a plugin that enables interaction with an API.  
This includes Cloud providers such as AWS, Azurerm, GCP.   
The providers are specified in the Terraform configuration code, telling Terraform which services it needs to interact with.  

```

provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

```
