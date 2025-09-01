# Create an AWS IAM Group and users


1. Switch to the account_management directory.

2. Revise the file named iam-devops-group.tf

3. Initialize Terraform

```
terraform init
```
```
terraform validate
```

```
terrafor plan
```

```
terraform apply
```
After running "terraform apply" you will need to input yes for terraform to run the tasks in your configuration.

# Obtaining user password
To obtain the initial password that AWS IAM created you can add this to a file like account_output.tf

The output below will not actually display any account passwords. However uncommenting the field below and running terraform output -json and locating the created user accounts will allow for obtaining unencrypted passwords for each account.

This is a *SERIOUS* subject and best practice would be to use the pgp_key = keybase format and encrypt the passwords.

[REFERENCE] 
https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_login_profile

```
#--------WARNING----------------#


# output "password" {
#   value     = aws_iam_user_login_profile.user_login_profile
#   sensitive = true

# }
```