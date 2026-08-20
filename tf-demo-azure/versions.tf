terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.60.0"
    }
  }
}

terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.45.0"
    }
  }
}

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "5.1.0"
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