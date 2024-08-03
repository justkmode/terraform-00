terraform {
  backend "s3" {
    bucket         = "my-terraform-state-learning"
    key            = "global/s3/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"  # Updated table name
  }
}
