terraform {
  backend "s3" {
    bucket = "terra-proj-state12"
    key    = "terraform/backend"
    region = "us-east-2"
  }
}