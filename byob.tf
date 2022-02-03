provider "aws" {
  region = var.aws_region
}

locals {
  bucket_names = toset(concat(var.bucket_names, formatlist("%s-%s", var.bucket_prefixes, lower(var.lmo_org_id))))
  bucket_arns  = [ for k, v in aws_s3_bucket.byob_storage : v.arn ]
}

resource "aws_s3_bucket" "byob_storage" {
  for_each = local.bucket_names
  bucket   = "${each.key}"
  acl      = "private"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "Abort incomplete uploads"
    enabled = true

    abort_incomplete_multipart_upload_days = 1
  }

  lifecycle_rule {
    id      = "Clean out test directory"
    prefix  = "test/"
    enabled = true

    expiration {
      days = 1
    }

    noncurrent_version_expiration {
      days = 1
    }
  }
}

resource "aws_iam_role" "byob_writer" {
  name        = "app_analytics_byob_writer"
  description = "Role to be assumed by the Salesforce App Analytics AWS account to upload data to the BYOB buckets"

  assume_role_policy = data.aws_iam_policy_document.byob_writer_assume_role_policy.json

  inline_policy {
    name   = "byob_writer_policy"
    policy = data.aws_iam_policy_document.byob_writer_policy.json
  }
}

data "aws_iam_policy_document" "byob_writer_assume_role_policy" {
  statement {
    actions = [ "sts:AssumeRole" ]

    principals {
      type        = "AWS"
      identifiers = [ "arn:aws:iam::${var.sfdc_aws_account}:root" ]
    }

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [ var.lmo_org_id ]
    }
  }
}

data "aws_iam_policy_document" "byob_writer_policy" {
  statement {
    actions   = [ "s3:PutObject" ]
    resources = formatlist("%v/*", local.bucket_arns)
  }

  statement {
    actions   = [ "s3:GetBucketLocation" ]
    resources = local.bucket_arns
  }
}

output "bucket_names" {
  value = [ for k, v in aws_s3_bucket.byob_storage : v.id ]
}

output "iam_role_arn" {
  value = aws_iam_role.byob_writer.arn
}

output "lmo_org_id" {
  value = var.lmo_org_id
}
