  terraform {
  backend "s3" {
    bucket = "gabby-dev-s3"
    key    = "gabby-dev/statefiles/terrform.tfstate"
    region = "us-west-1"
    encrypt        = true
    dynamodb_table = "terraform-state-lock"
  }
}
