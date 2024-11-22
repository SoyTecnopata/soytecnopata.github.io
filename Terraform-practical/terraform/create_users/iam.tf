data "aws_iam_policy_document" "allow_ec2_free_tier_creation" {
  statement {
    sid       = "AllowLaunchT2T3MicroInstances"
    effect    = "Allow"
    actions   = [
      "ec2:RunInstances",
      "ec2:StopInstances",
    "ec2:TerminateInstances",
    "ec2:StartInstances"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      values = ["t2.micro",
              "t3.micro"]
      variable = "ec2:InstanceType"
    }
  }

  statement {
    sid       = "AllowDescribeInstances"
    effect    = "Allow"
    actions   = [
      "ec2:DescribeInstances",
      "ec2:DescribeImages",
      "ec2:DescribeInstanceTypes"]
    resources = ["*"]
  }
}

resource "aws_iam_user_policy" "inno_terraform" {
  for_each = local.users
  name   = "inno_terraform_policy_${each.value}"
  user   = aws_iam_user.inno_user[each.value].name
  policy = data.aws_iam_policy_document.allow_ec2_free_tier_creation.json
}


resource "aws_iam_user" "inno_user" {
  for_each = local.users
  name = each.value
  path = "/inno/"

  tags = {
    username = each.value
  }
}

resource "aws_iam_access_key" "inno_user_key" {
  for_each = local.users
  user = aws_iam_user.inno_user[each.value].name

}
