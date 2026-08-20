terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.60.0"
    }
  }
}
#alias is used for multiple provider
provider "aws" {
  profile = "aws-master-admin"
  alias   = "master"
  region  = "ap-southeast-2"
}

#you don't need to add region in versions for IAM (Global resources)
#need to add in VPC (Regional resources)
provider "aws" {
  profile = "aws-master-admin"
  alias   = "singapore" 
  region = "ap-southeast-1"
}
provider "aws" {
  profile = "aws-master-admin"
  alias   = "japan"
  region  = "ap-northeast-1"
}

provider "aws" {
  profile = "aws-dev-admin"
  alias   = "dev"
  region  = "ap-southeast-2"
}
provider "aws" {
  profile = "aws-prod-admin"
  alias   = "prod"
  region  = "ap-southeast-2"
}