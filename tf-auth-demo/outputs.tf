#aws_master_admin
output "aws-master-admin_user_id" {
  description = "Unique identifier of the calling entity"
  value       = data.aws_caller_identity.aws-master-admin.user_id
}
output "aws-master-admin_id" {
  description = "Account ID number of the account that owns or contains the calling entity"
  value       = data.aws_caller_identity.aws-master-admin.id
}
output "aws-master-admin_arn" {
  description = "ARN associated with the calling entity."
  value       = data.aws_caller_identity.aws-master-admin.arn
}

output "singapore_vpc" {
  value       = data.aws_vpc.master_admin_singapore_vpc.id
}
output "japan_vpc" {
  value       = data.aws_vpc.master_admin_japan_vpc.cidr_block
}

#aws_dev_admin
output "aws-dev-admin_user_id" {
  description = "Unique identifier of the calling entity"
  value       = data.aws_caller_identity.aws-dev-admin.user_id
}
output "aws-dev-admin_id" {
  description = "Account ID number of the account that owns or contains the calling entity"
  value       = data.aws_caller_identity.aws-dev-admin.id
}
output "aws-dev-admin_arn" {
  description = "ARN associated with the calling entity."
  value       = data.aws_caller_identity.aws-dev-admin.arn
}
#aws_prod_admin
output "aws-prod-admin_user_id" {
  description = "Unique identifier of the calling entity"
  value       = data.aws_caller_identity.aws-prod-admin.user_id
}
output "aws-prod-admin_id" {
  description = "Account ID number of the account that owns or contains the calling entity"
  value       = data.aws_caller_identity.aws-prod-admin.id
}
output "aws-prod-admin_arn" {
  description = "ARN associated with the calling entity."
  value       = data.aws_caller_identity.aws-prod-admin.arn
}