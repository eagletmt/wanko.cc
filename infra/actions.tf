data "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
}

resource "aws_iam_role" "actions-wanko-cc" {
  name               = "actions-wanko-cc"
  assume_role_policy = data.aws_iam_policy_document.actions-wanko-cc-assume-role.json
}

data "aws_iam_policy_document" "actions-wanko-cc-assume-role" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    principals {
      type        = "Federated"
      identifiers = [data.aws_iam_openid_connect_provider.github.arn]
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values   = data.aws_iam_openid_connect_provider.github.client_id_list
    }
    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:eagletmt/wanko.cc:ref:refs/heads/main"]
    }
  }
}

resource "aws_iam_role_policy" "actions-wanko-cc" {
  role   = aws_iam_role.actions-wanko-cc.name
  name   = "deploy"
  policy = data.aws_iam_policy_document.actions-wanko-cc.json
}

data "aws_iam_policy_document" "actions-wanko-cc" {
  statement {
    actions   = ["s3:ListBucket"]
    resources = [aws_s3_bucket.wanko-cc.arn]
  }
  statement {
    actions   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"]
    resources = ["${aws_s3_bucket.wanko-cc.arn}/*"]
  }
  statement {
    actions   = ["cloudfront:CreateInvalidation"]
    resources = [aws_cloudfront_distribution.wanko-cc.arn]
  }
}
