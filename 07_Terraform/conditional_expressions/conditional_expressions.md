What is Conditional Expressions ?
----------------------
Conditional expressions in Terraform allow you to control the flow of execution of your configuration code based on the evaluation of a Boolean expression.     
This can be useful for a variety of reasons, such as creating resources only when certain conditions are met,  
or using different values for resources depending on the environment in which they are being deployed.   

```
variable "environment" {
  description = "Environment type"
  type        = string
  default     = "development"
}

variable "production_subnet_cidr" {
  description = "CIDR block for production subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "development_subnet_cidr" {
  description = "CIDR block for development subnet"
  type        = string
  default     = "10.0.2.0/24"
}

resource "aws_security_group" "example" {
  name        = "example-sg"
  description = "Example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.environment == "production" ? [var.production_subnet_cidr] : [var.development_subnet_cidr]
  }
}
```
