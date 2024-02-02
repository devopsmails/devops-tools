what is Multi Provders?  
------------------
Multiproviders can also be used to manage resources in different cloud providers.   

For example, the following Terraform code defines two provider aliases, one for the AWS provider and one for the Azure provider:  

```
provider "aws" {
  alias = "aws"
  region = "us-east-1"
}

provider "azurerm" {
  alias = "azure"
}
```
Resourece creation in Multi Providers?  
-----------------------
```
resource "aws_instance" "example" {
  provider = "aws.aws"
  ami = "ami-01234567890abcdef0"
  instance_type = "t2.micro"
}

resource "azurerm_virtual_machine" "example2" {
  provider = "azurerm.azure"
  location = "eastus2"
  resource_group_name = "my-resource-group"
  name = "my-vm"
  vm_size = "Standard_A1"
}
```
