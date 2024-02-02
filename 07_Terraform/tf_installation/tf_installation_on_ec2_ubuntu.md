O_Docs: https://developer.hashicorp.com/terraform/downloads  
doc: https://github.com/iam-veeramalla/terraform-zero-to-hero/blob/main/Day-1/03-install.md   

```
wget -O- https://apt.releases.hashicorp.com/gpg : sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" : sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform

```

TF Commands:  
-------------
```
  terraform init :
    Initializes the Terraform working directory. (Necessary before running any other Terraform commands)

  terraform plan :
    Generates a plan of the changes that Terraform will make to the infrastructure. (Useful for previewing changes before applying them)

  terraform apply :
    Creates or updates the infrastructure to match the Terraform configuration. (This is the command that actually makes the changes)

  terraform import :
    Adds an existing resource to the Terraform state. (Useful for migrating existing infrastructure to Terraform)

  terraform destroy :
    Destroys the infrastructure managed by Terraform. (This should be used with caution)

  terraform show :
    Show the statefile present

  terraform state rm :
    Removes a resource from the Terraform state. (Useful for cleaning up unused resources) 
```
