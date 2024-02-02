variable "region" {
  
}
variable "ami" {
  
}
variable "instance_type" {

}


provider "aws" {
    region = lookup(var.region, terraform.workspace, "us-east-1" )
}

resource "aws_instance" "example" {
  ami = lookup(var.ami, terraform.workspace, "ami-0f5ee92e2d63afc18" )
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}
