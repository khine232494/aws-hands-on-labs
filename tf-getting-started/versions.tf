terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.61.0"
    }
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "5.2.0"
    # }
    # kubernetes = {
    #   source  = "hashicorp/kubernetes"
    #   version = "3.2.1"
    # }
    # docker = {
    #   source  = "kreuzwerker/docker"
    #   version = "4.5.0"
    # }
  }
}

provider "aws" {
  # Configuration options
  profile = "aws-master-admin"
  region  = "ap-southeast-2"
}