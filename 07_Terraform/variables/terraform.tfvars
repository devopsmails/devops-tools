What is terraform.tfvars ?  
---------------------
Terraform.tfvars files are external files that contain variable definitions.   
They are typically used to store sensitive data, such as passwords and API keys.    
Terraform.tfvars files can be loaded when you run terraform apply, and the values in the file will be used to populate the variables in your configuration code.

```
terraform apply -var-file=dev.tfvars
```
