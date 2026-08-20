data "aws_vpc" "aws_master_admin-vpc-abc" {
  provider = aws.aws_master_admin
}

data "aws_vpc" "aws_dev_admin-vpc-def" {
  provider = aws.aws_dev_admin
}

data "aws_vpc" "aws_prod_admin-vpc-xyz" {
  provider = aws.aws_prod_admin
}