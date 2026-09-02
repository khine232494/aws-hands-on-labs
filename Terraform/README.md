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
-> terraform apply
-> terraform providers (it will show the list of providers)
 
What is terraform init?
[ .tf code ] 
     ↓
terraform init 
     ↓
Internet (Terraform Registry)
     ↓
Download Plugins
     ↓
Local Computer (.terraform/ & .terraform.lock.hcl)
The first command prepares the Local Workspace to start working with Terraform configuration files (.tf).

You can only run terraform init from a directory containing a Terraform configuration file (.tf).

- Terraform init is used to initialize a working directory containing Terraform configuration files, which is called a “module”. This is useful when writing Terraform configuration files and you want to start with a clean module folder.

What is terraform fmt?
- Terraform fmt is used to rewrite tf conf files to a canonical format and style.   

What is terraform validate?
- Terraform validate is used to check if the configuration files are valid. If the configuration is not valid, Terraform will show an error message and stop the execution of the command.  

What is terraform plan?
- Terraform plan is used to create an execution plan. This execution plan shows what Terraform will do when you call apply.

What is terraform apply?
- Terraform apply is used to create or change infrastructure. Terraform will compare the configuration defined in the configuration files with the real world to determine what needs to be changed.

What is terraform apply?
- Terraform apply is used to create or change infrastructure. Terraform will compare the configuration defined in the configuration files with the real world to determine what needs to be changed.

What is terraform destroy?
- Terraform destroy is used to destroy Terraform-managed infrastructure. This is useful when you want to destroy infrastructure that was created by Terraform.   


# Debugging Terraform

- https://registry.terraform.io/providers/NetApp/netapp-ontap/latest/docs/guides/debugging

- TRACE: Very detailed logs, including internal Terraform operations.
- DEBUG: Detailed logs useful for debugging. (DEBUG is good enough for most of the cases)
- INFO: General information about Terraform operations.
- WARN: Warnings about potential issues.
- ERROR: Only error messages.

# DEBUG is good enough for most of the cases
export TF_LOG=DEBUG
export TF_LOG_PROVIDER=DEBUG

# init
export TF_LOG=DEBUG
export TF_LOG_PATH=/Users/pwintphyukhine/aws-hands-on-labs/tf-getting-started/1-terraform_init.log
terraform init

# info
export TF_LOG=INFO
export TF_LOG_PATH=/Users/pwintphyukhine/aws-hands-on-labs/tf-getting-started/5-terraform_info.log

# fmt
export TF_LOG=DEBUG
export TF_LOG_PATH=/Users/pwintphyukhine/aws-hands-on-labs/tf-getting-started/2-terraform_fmt.log
terraform fmt

# validate
export TF_LOG=DEBUG
export TF_LOG_PATH=/Users/pwintphyukhine/aws-hands-on-labs/tf-getting-started/3-terraform_validate.log
terraform validate

# plan
export TF_LOG=DEBUG
export TF_LOG_PATH=/Users/pwintphyukhine/aws-hands-on-labs/tf-getting-started/4-terraform_plan.log
terraform plan

# apply
export TF_LOG=DEBUG
export TF_LOG_PATH=/Users/pwintphyukhine/aws-hands-on-labs/tf-getting-started/6-terraform_apply.log
terraform apply -auto-approve   




data.tf or main.tf 

# tf3-Sep-2024

- terraform init
- terraform fmt
- terraform validate
- terraform plan
- terraform apply -auto-approve

*** terraform destroy first and then it will create


brew install direnv

direnv allow .

vi ~/.bash_profile
source ~/.bash_profile


cat ~/.bash_profile
eval "$(direnv hook bash)"

why we should share terraform state?    

- to share state between different team
- to share state between different developer
- to share state between different environment

# tfstate

- tfstate is a file that stores the state of your infrastructure.

- run tarraform login <- to create api

store the token in this route /Users/p2k/.terraform.d/credentials.tfrc.json 