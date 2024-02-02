variable "region" {
  description = "Various regions for diff env"
  type = map(string)

  default = {
    "dev" = "ap-south-1"
    "pprod" = "us-west-1"
    "prod" = "us-east-1"
  }
}

variable "ami" {
  description = "Various ami for diff env"
  type = map(string)

  default = {
    "dev" = "ami-0f5ee92e2d63afc18"
    "pprod" = "ami-0f8e81a3da6e2510a"
    "prod" = "ami-053b0d53c279acc90"
  }
}

variable "instance_type" {
  description = "Various instance_type for diff env"
  type = map(string)

  default = {
    "dev" = "t2.micro"
    "pprod" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2_instance" {
    source = "./ec2_instance"
    region = var.region
    ami = var.ami
    instance_type = var.instance_type
}
