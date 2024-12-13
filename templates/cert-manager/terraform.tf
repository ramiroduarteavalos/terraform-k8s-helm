terraform {
  backend "s3" {
    bucket = "example-${product}-tfstate"
    key     = "${product}/monitoring"
    access_key = "xxxxxxxxxxxxxx"
    secret_key = "xxxxxxxxxxxxxx"
    region = "us-east-1"   
  }
}