resource "aws_instance" "gabby-dev" {
    ami = var.ami_value
    instance_type = var.instance_type_value
     
}
