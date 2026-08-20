data "aws_caller_identity" "aws-master-admin" {
  provider = aws.master
}

data "aws_caller_identity" "aws-dev-admin" {
  provider = aws.dev
}

data "aws_caller_identity" "aws-prod-admin" {
  provider = aws.prod
}