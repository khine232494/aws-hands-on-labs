data "aws_vpc" "aws-master-admin-vpc-abc" {
  provider = aws.aws-master-admin
}

data "aws_vpc" "aws-dev-admin-vpc-def" {
  provider = aws.aws-dev-admin
}

data "aws_vpc" "aws-prod-admin-vpc-xyz" {
  provider = aws.aws-prod-admin
}