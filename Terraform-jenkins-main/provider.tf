provider "aws" {
  region                   = var.Region
  shared_credentials_files = ["~/.aws/credentials"]
}
