What is Multi Region?  
--------------------    
Terraform to manage infrastructure in multiple regions.   
This can be useful for a variety of reasons, such as improving performance, reliability, and disaster recovery.  

```
provider "aws" {
  alias = "us-east-1" ##### This shuold be attached to the resource we want to create #######
  region = "us-east-1"
}

provider "aws" {
  alias = "us-west-2"   ##### This shuold be attached to the resource we want to create #######
  region = "us-west-2"
}
```
Attaching multi regions while creating resources:  
---------------------
```
resource "aws_instance" "example" {
  provider = "aws.us-east-1"   ##### alias value is for the region is attached here ####
  ami = "ami-01234567890abcdef0"
  instance_type = "t2.micro"
}

resource "aws_instance" "example2" {
  provider = "aws.us-west-2"      ##### alias value is for the region is attached here ####
  ami = "ami-01234567890abcdef1"
  instance_type = "t2.micro"
}
```
