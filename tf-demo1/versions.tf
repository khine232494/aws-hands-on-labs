terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.60.0"
    }
  }
}

provider "aws" {
  shared_config_files      = ["/Users/pwintphyukhine/.aws/config"]
  shared_credentials_files = ["/Users/pwintphyukhine/.aws/credentials"]
  profile                  = "aws-master-admin"
  alias                    = "aws-master-admin"
  region                   = "us-east-1"
}

provider "aws" {
  shared_config_files      = ["/Users/pwintphyukhine/.aws/config"]
  shared_credentials_files = ["/Users/pwintphyukhine/.aws/credentials"]
  profile                  = "aws-dev-admin"
  alias                    = "aws-dev-admin"
  region                   = "ap-northeast-1"
}

provider "aws" {
  shared_config_files      = ["/Users/pwintphyukhine/.aws/config"]
  shared_credentials_files = ["/Users/pwintphyukhine/.aws/credentials"]
  profile                  = "aws-prod-admin"
  alias                    = "aws-prod-admin"
  region                   = "ap-southeast-1"
}