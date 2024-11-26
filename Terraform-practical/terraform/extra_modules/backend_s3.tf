terraform {
  required_version = "~> 1.0"

  backend "s3" {
    bucket               = "test-inno-terraform-25112024"
    key                  = "terraform.tfstate"
    region               = "eu-west-3"
    workspace_key_prefix = "inno/terraform/alma"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.77"
    }
  }
}

module "s3_bucket" {
  source = "terraform-aws-modules/s3-bucket/aws"

  bucket = "inno-terraform-26112024"
  acl    = "private"

  control_object_ownership = true
  object_ownership         = "ObjectWriter"

  versioning = {
    enabled = false
  }
}

data "aws_iam_policy_document" "allow_s3_backend" {
  for_each = local.users
  statement {
    sid       = "AllowListBuckets"
    effect    = "Allow"
    actions   = [
     "s3:ListBucket"]
    resources = ["*"]
  }

  statement {
    sid       = "AllowWriteInPath"
    effect    = "Allow"
    actions   = [
      "s3:GetObject",
      "s3:PutObject"]
    resources = ["${module.s3_bucket.s3_bucket_arn}/inno/terraform/${each.value}"]
  }
  
}

data "aws_iam_policy_document" "combined" {
  for_each = local.users
  source_policy_documents = [
    data.aws_iam_policy_document.allow_ec2_free_tier_creation.json,
    data.aws_iam_policy_document.allow_s3_backend[each.value].json
  ]
}


