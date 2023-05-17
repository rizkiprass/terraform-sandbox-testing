data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "mgmt-event-cloudtrail" {
  name                          = "test-dev-trails"
  s3_bucket_name                = aws_s3_bucket.mgmt-ct-bucket.id
  s3_key_prefix                 = "mgmt"
  include_global_service_events = false
}

resource "aws_s3_bucket" "mgmt-ct-bucket" {
  bucket        = "test-poc-mgmt-trail-bucket-723"
  force_destroy = true
}

data "aws_iam_policy_document" "trail-policy" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [aws_s3_bucket.mgmt-ct-bucket.arn]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:PutObject"]
    resources = ["${aws_s3_bucket.mgmt-ct-bucket.arn}/mgmt/AWSLogs/${data.aws_caller_identity.current.account_id}/*"]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}
resource "aws_s3_bucket_policy" "ct-bucket-policy" {
  bucket = aws_s3_bucket.mgmt-ct-bucket.id
  policy = data.aws_iam_policy_document.trail-policy.json
}