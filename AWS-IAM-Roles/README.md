# Session-02

In AWS, there are two types of Identity:

1. IAM users
   - Can create Access Keys and Secret Access Keys (Long Lived Credentials and Never Expire)
   - Using these keys, You can comunicate with AWS services and you can access AWS resources (CRUD operations)
   - Have permissions policies to access AWS resources

2. IAM roles
   - Cann't create Access Keys and Secret Access Keys
   - Have permissions policies to access AWS resources
   - Trust relationship policy
   - Cross-account access
   - Web Identity Federation (Google, Facebook, etc)

If you use IAM roles, automatically show cli in .aws.

aws sts get-caller-identity --profile master-programmatic-admin-role --debug

- If you modify the IAM user credentials in ~/.aws/credentials and run:

  - " aws sts get-caller-identity --profile master-programmatic-admin"
   you will receive an error: (InvalidClientTokenId) 403

- But, when running the command with an IAM role profile:

   - "aws sts get-caller-identity --profile master-programmatic-admin-role --debug"

      it still valid. Coz temporary credentials rely on an aws_session_token paired with 
      the temporary Access Key ID and Secret Access Key, keeping the session valid until it expires.


- rm -rf cli/
you can run the command with the IAM role profile. you will receive an error: (AccessDenied) 403.

Access Keys and Secret Access Keys of IAM roles are dynamically generated for IAM users.
It depends on the IAM user credentials.

- Give permission IAMReadOnlyAccess to the IAM role
And run again 
aws iam list-users --profile master-programmatic-admin-role --debug

# Trust cross account access

- Create a role in the dev-programmatic-admin-role account of the dev account
- And give permission to the role to access the IAM user account of the master-programmatic-admin-role account
- edit config file ~/.aws/config
- check the credential file ~/.aws/credentials
- run this command
- aws iam list-users --profile dev-programmatic-admin-role --debug
(Check in the debug-dev-pg-admin-role.log)
- got this error
aws: [ERROR]: An error occurred (AccessDenied) when calling the AssumeRole operation: User: arn:aws:sts::384043731966:assumed-role/master-programmatic-admin-role/botocore-session-1786292817 is not authorized to perform: sts:AssumeRole on resource: arn:aws:iam::411232894690:role/dev-programmatic-admin-role
- Actor 
   -> arn:aws:sts::384043731966:assumed-role/master-programmatic-admin-role

- Action
   -> sts:AssumeRole

- On Resource
   -> arn:aws:iam::411232894690:role/dev-programmatic-admin-role

- found this error coz there is no permission in master-programmatic-admin-role account.
- give permissin in the master-programmatic-admin-role account to access the dev-programmatic-admin-role account
- create inline policy in the master-programmatic-admin-role account
{
        "Version": "2012-10-17",
        "Statement": [
                {
                        "Effect": "Allow",
                        "Action": "sts:AssumeRole",
                        "Resource": [
                                "arn:aws:iam::411232894690:role/dev-programmatic-admin-role"
                        ]
                }
        ]
}

# Run this command again
- aws iam list-users --profile dev-programmatic-admin-role --debug
(Check in the debug-dev-pg-admin-role2.log)
- got this error
aws: [ERROR]: An error occurred (AccessDenied) when calling the ListUsers operation: User: arn:aws:sts::411232894690:assumed-role/dev-programmatic-admin-role/botocore-session-1786294060 is not authorized to perform: iam:ListUsers on resource: arn:aws:iam::411232894690:user/ because no identity-based policy allows the iam:ListUsers action

- Actor 
   -> arn:aws:sts::411232894690:assumed-role/dev-programmatic-admin-role

- Action
   -> iam:ListUsers

- On Resource
   -> arn:aws:iam::411232894690:user

- why got this error?
   - Check the permissions in dev-programmatic-admin-role
   - only the permissions has AmazonVPCReadOnlyAccess
   - add IAMReadOnlyAccess

# Run this command again
aws iam list-users --profile dev-programmatic-admin-role --debug
(Check in the debug-dev-pg-admin-role3.log)

{
    "Users": [
        {
            "Path": "/",
            "UserName": "dev-console-admin",
            "UserId": "AIDAV7P3D73RK62AMIFQH",
            "Arn": "arn:aws:iam::411232894690:user/dev-console-admin",
            "CreateDate": "2026-08-09T05:09:10+00:00",
            "PasswordLastUsed": "2026-08-09T16:53:27+00:00"
        },
        {
            "Path": "/",
            "UserName": "dev-programmatic-admin",
            "UserId": "AIDAV7P3D73RK6GBCA5Q7",
            "Arn": "arn:aws:iam::411232894690:user/dev-programmatic-admin",
            "CreateDate": "2026-08-09T05:17:22+00:00"
        }
    ]
}

# Summary
- within the same account, you can access the resources of other account
- but, you can't access the resources of other account from the same account

- But for cross-account access, you need to create inline policy in the trust account.
