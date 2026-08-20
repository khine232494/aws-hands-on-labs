# Terraform

- to create IAM user and access key
- IAM user is only identity and not have any permissions in AWS account.
- To get permissions, need to attach Policy to IAM user.

# Only creating IAM user can't do anything in AWS account. If you want to use this IAM user, you need to attach Policy to it.

Terraform
- create IAM user from aws UI 
- run this command to link with IAM user from CLI
**** aws configure --profile aws-master-admin
- create access key and secret access key from IAM user From aws UI
- copy access key and secret access key to CLI 
- you can find 
~/.aws/config -----> [profile aws-master-admin]
                    region = ap-southeast-2
                    output = json
# to delete default profile ( one of the best practice)
                
~/.aws/credentials -----> [aws-master-admin]
                            aws_access_key_id = xxxxxxx
                            aws_secret_access_key = xxxxxxx



#To verify using awscli
aws sts get-caller-identity --profile aws-master-admin

1. Verify terraform version ( if not installed, install it)
    - brew install tfenv
    - tfenv install latest
    - tfenv use latest
    - terraform version
            or 
    - brew tap hashicorp/tap
    - brew install hashicorp/tap/terraformn
    - terraformn version
2. Verify terraform init

# This is the basic structure of a Terraform project.
1. main.tf
2. variables.tf
3. outputs.tf
4. versions.tf


when run (terraform init) command from cli, what does happen?
-Initializing provider plugins...
- Finding hashicorp/aws versions matching "6.60.0"...
- Installing hashicorp/aws v6.60.0...
- Installed hashicorp/aws v6.60.0 (signed by HashiCorp)
and then backend

-> terraform init
-> terraform plan




