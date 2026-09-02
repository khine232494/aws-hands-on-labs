output "aws-master-admin" {
  value = data.vault_auth_backend.vault-master-admin.*
}   
output "aws-dev-admin" {
  value = data.vault_auth_backend.vault-dev-admin.*
}