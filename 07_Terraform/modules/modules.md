what is modules ?  
-------------------

Terraform modules are a way to package and reuse Terraform code.  
They allow you to define a collection of resources and their configuration in one place, and then reuse that code in multiple configurations.  
Modules are defined in a directory, which contains a set of Terraform configuration files (.tf files).   
The directory must also contain a module.tf file, which defines the module's inputs and outputs.    
To use a module in your configuration, you use a module block. The module block specifies the source of the module and the values for its inputs.   

Modules can also call other modules, which allows you to build complex infrastructure configurations out of smaller, reusable components.  
Feaures: 
--------
Reuse
Modularity
Testability

Here is an example of a simple Terraform module that creates an EC2 instance:
```
# module.tf

module "my_ec2_instance" {
  source = "hashicorp/aws/ec2"

  instance_type = "t2.micro"
  ami = "ami-01234567890abcdef0"
}
```
To use this module in your configuration, you would use the following module block:
```
module "my_ec2_instance" {
  source = "./my_ec2_instance"
}
```
