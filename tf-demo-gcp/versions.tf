terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.45.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/Users/pwintphyukhine/.aws/config"]
  shared_credentials_files = ["/Users/pwintphyukhine/.aws/credentials"]
  profile                  = "aws_master_admin"
}

provider "aws" {
  shared_config_files      = ["/Users/pwintphyukhine/.aws/config"]
  shared_credentials_files = ["/Users/pwintphyukhine/.aws/credentials"]
  profile                  = "aws_dev_admin"
}

provider "aws" {
  shared_config_files      = ["/Users/pwintphyukhine/.aws/config"]
  shared_credentials_files = ["/Users/pwintphyukhine/.aws/credentials"]
  profile                  = "aws_prod_admin"
}


provider "google" {
  project     = "my-project-id"
  region      = "us-central1"
  zone        = "us-central1-c"
}


provider "azurerm" {
  # Configuration options
}