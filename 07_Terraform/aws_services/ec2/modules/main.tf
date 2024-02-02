provider "aws" {
    region = "us-west-1"
    
}

module "aws_instance" {
    source = "../normal_ec2"
    ami_value = "ami-04d1dcfb793f6fa37"
    instance_type_value = "t2.micro"
  
}
