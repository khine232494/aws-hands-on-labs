output "aws-master-admin-vpc-output" {
    value = data.aws_vpc.aws-master-admin-vpc-abc.arn
}

output "aws-dev-admin-vpc-output" {
    value = data.aws_vpc.aws-dev-admin-vpc-def.dhcp_options_id
}

output "aws-prod-admin-vpc-output" {
    value = data.aws_vpc.aws-prod-admin-vpc-xyz.cidr_block
}