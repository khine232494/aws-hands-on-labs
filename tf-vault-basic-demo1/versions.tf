terraform {
  required_providers {
    vault = {
      source  = "hashicorp/vault"
      version = "5.11.0"
    }
  }
}

provider "vault" {
  # Configuration options
  address = "http://127.0.0.1:8200" #vault server 1
  token   = variable.vault-token1
  alias   = "vrd1"
}

provider "vault" {
  # Configuration options
  address = "http://127.0.0.1:8202" #vault server 2
  token   = variable.vault-token2
  alias   = "vrd2"
}