data "aws_vpc" "master_admin_singapore_vpc" {
  provider = aws.singapore
  default = true  
}
data "aws_vpc" "master_admin_japan_vpc" {
  provider = aws.japan
  default = true  
}