  Why Variables used ?
---------------------

By using Terraform variables, you can make your configuration more reusable, maintainable, and consistent.  
Terraform variables can be used to define a wide variety of values, and they can be used in any part of your Terraform configuration.   

Variable Block:  
-------------
```
variable "instance_type" {
  type = string
  description = "The type of EC2 instance to launch."
  default = "t2.micro"
}
```
```variable``` is used to declare an input variable named ```instance_type```.  
```description``` provides a human-readable description of the variable.  
```type ``` specifies the data type of the variable:
  > ```string```: A sequence of Unicode characters.  
  > ```number```: A numeric value.   
  > ```bool```: A boolean value, either true or false.  
  > ```list```: A sequence of values.  
  > ```map```: A collection of key-value pairs.  
  > ```set```: A collection of unique values.  
  > ```object```: A collection of named attributes.  
  >```tuple:``` A collection of values with a specific order.  
```default``` provides a default value for the variable, which is optional.  

Attaching Variables in resources:
------------------------------
```
resource "aws_instance" "example" {
  ami = "ami-01234567890abcdef0"
  instance_type = var.instance_type   #### Attaching variable here ####
}
```

Variable Types:
============== 
1. Input Variables:
   ---------------
   Input variables are used to pass values to a Terraform module when it is called.  
   This can be done through the terraform apply command-line options or through a variables file.

   ```
   terraform apply -var ami_id=ami-1234567890abcdef1
   ```
hcl
```
# Define an input variable for the EC2 instance type
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# Define an input variable for the EC2 instance AMI ID
variable "ami_id" {
  description = "EC2 AMI ID"
  type        = string
}

# Configure the AWS provider using the input variables
provider "aws" {
  region      = "us-east-1"
}

# Create an EC2 instance using the input variables
resource "aws_instance" "example_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
}
   ```

2. Output Variables:
   ----------------
   Output variables are used to expose the values of resources that are created by a Terraform module.
   These values can then be used by other modules or by the calling module.  
```
# Define an output variable to expose the public IP address of the EC2 instance
output "public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_instance.example_instance.public_ip
}

```

