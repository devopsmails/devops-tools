provider "aws" {
  region = "us-west-1"
}

resource "aws_instance" "gabby_dev_instance" {
  ami = "ami-04d1dcfb793f6fa37"
  instance_type = "t2.micro"
}

resource "aws_s3_bucket" "gabby_dev_s3" {
  bucket = "gabby-dev-s3"
}

### Till here need to apply first """
resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
