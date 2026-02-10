#IAM role and instance profile for SSM Session Manager

data "aws_iam_policy_document" "ssm_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ssm_ec2_role" {
  name               = "${local.name}-ssm-ec2-role"
  assume_role_policy = data.aws_iam_policy_document.ssm_assume_role.json
  tags               = local.common_tags
}

resource "aws_iam_role_policy_attachment" "ssm_managed_core" {
  role       = aws_iam_role.ssm_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${local.name}-ssm-instance-profile"
  role = aws_iam_role.ssm_ec2_role.name
  tags = local.common_tags
}
