# Session-01

1. Find the solutin to access the billing for IAM user account that has adminstrator access.
   - Login with console account
   - In the top-right navigation bar, click on your Account Name /  Account ID and select Account from the drop-down menu.
   - Scroll down to the IAM User and Role Access to Billing Information section.
   - Click Edit.  
   - Select the check box for Activate IAM Access.
   - Click Update. 

# ARN (Amazon Resource Name)
- ARN is a unique identifier for AWS resources
- ARN is in the format of
  - arn:partition:service:region:account-id:resource
  - partition: Identifies the AWS partition that the resource is in. For example, the partition for an AWS account is aws.

    # Partition (Standard Partitions)
        aws - AWS Regions
        aws-cn - China Regions
        aws-us-gov - AWS GovCloud (US) Regions
        (aws-iso - AWS GovCloud (ISO) Regions)

    # partition and regions can be found here
    - https://github.com/boto/botocore/blob/develop/botocore/data/partitions.json

- vi ~/.aws/credentials (vim ~/.aws/credentials)

- cat ~/.aws/config

- aws sts get-caller-identity --profile master-programmatic-admin 
- aws sts get-caller-identity --profile master-programmatic-admin --region ap-southeast-2
- aws sts get-caller-identity --profile master-programmatic-admin --region ap-southeast-2 --debug
(See in debug.log)

- aws sts get-caller-identity --profile master-programmatic-admin --region ap-southeast-2 --debug
(Test with Wrong access key id and secret access key) => get the error (InvalidClientTokenId) 403 306

- aws ec2 describe-vpcs --profile master-programmatic-admin --region ap-southeast-2 --debug 
(See in debug3.log) => get the error (UnauthorizedOperation) 403 None







