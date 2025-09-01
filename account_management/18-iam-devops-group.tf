# Create AWS IAM group and add users to the group.


# This variable file provides the acounts that can be created by an
# authorized administrator.

# List of usernames
# You should replace these test accounts with actual user accounts.

variable "devops_usernames" {
  type        = list(string)
  default     = ["JangoFett", "CountDooku", "GeneralGrievous", "Emperor", "MaceWindu"]
  description = "List of usernames to be allowed access to AWS"
}


# Create an AWS IAM group

resource "aws_iam_group" "devops_group" {
  name = "class06_aws_devops_group"

}

# Resource to create an AWS IAM user.

resource "aws_iam_user" "userlist" {
  count         = length(var.devops_usernames)
  name          = element(var.devops_usernames, count.index)
  force_destroy = true

}

resource "aws_iam_user_login_profile" "user_login_profile" {
  count                   = length(var.devops_usernames)
  user                    = element(var.devops_usernames, count.index)
  password_length         = 40
  password_reset_required = true

}


# Associate AWS IAM users to group.

resource "aws_iam_user_group_membership" "user_group_membership" {
  count  = length(var.devops_usernames)
  user   = element(var.devops_usernames, count.index)
  groups = [aws_iam_group.devops_group.name, ]


}

# Create passwords


# Setup IAM policy for Read Only access to a specific S3 bucket.

resource "aws_iam_policy" "dev_group_s3_policy" {
  name        = "devgroup-s3-policy"
  description = "Policy for Read Only access to a S3 bucket"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "LocateBucket",
        "Effect" : "Allow",
        "Action" : "s3:GetBucketLocation",
        "Resource" : "arn:aws:s3:::demo-bucket300"
      },
      {
        "Sid" : "ListObjectsInBucket",
        "Effect" : "Allow",
        "Action" : "s3:ListBucket",
        "Resource" : "arn:aws:s3:::demo-bucket300"
      },
    ]
  })
}

resource "aws_iam_group_policy_attachment" "dev_group_s3_policy" {
  group      = aws_iam_group.devops_group.name
  policy_arn = aws_iam_policy.dev_group_s3_policy.arn

}

