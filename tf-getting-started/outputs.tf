output "aws-master-admin" {
    description = "The AWS account ID of the current user"
    value = data.aws_caller_identity.aws-master-admin
}