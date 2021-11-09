resource "aws_iam_instance_profile" "ec2_default_profile" {
  name = "ec2-default-profile-${data.aws_region.current.name}"
  role = aws_iam_role.ec2_default_iam_role.name
  tags = local.tags
}

resource "aws_iam_role" "ec2_default_iam_role" {
  name        = "ec2-default-profile-${data.aws_region.current.name}"
  description = "NAT EC2 instance profile to perform required EC2 actions."
  path        = "/"
  tags        = local.tags

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ec2_default_iam_policy_ec2_attach" {
  role       = aws_iam_role.ec2_default_iam_role.name
  policy_arn = local.ec2_ssm_iam_policy_arn
}
