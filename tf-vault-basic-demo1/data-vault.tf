data "vault_auth_backend" "vault-master-admin" {
  provider = vault.vrd1
  path     = "aws-master-admin"
}

data "vault_auth_backend" "vault-dev-admin" {
  provider = vault.vrd2
  path     = "aws-dev-admin"
}