provider "aws" {
  region = "ap-northeast-1"
}

resource "random_pet" "server" {
  length = 1
}

module "dynamodb" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0.0"

  name                        = "tech-books-explorer-dynamodb-${random_pet.server.id}"
  hash_key                    = "title"
  range_key                   = "published_at"
  table_class                 = "STANDARD_INFREQUENT_ACCESS"
  deletion_protection_enabled = false

  attributes = var.dynamodb_attributes

  import_table = {
    input_format           = "CSV"
    input_compression_type = "NONE"
    bucket                 = module.csv_s3_bucket.s3_bucket_id
    key_prefix             = module.csv_s3_bucket.s3_bucket_id
    input_format_options = {
      csv = {
        delimiter = ","
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

module "csv_s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0.0"

  bucket = "tech-books-explorer-bucket-${random_pet.server.id}"

  force_destroy = true
}

module "s3_import_object_csv" {
  source  = "terraform-aws-modules/s3-bucket/aws//modules/object"
  version = "~> 4.0.0"

  bucket = module.csv_s3_bucket.s3_bucket_id
  key    = "${module.csv_s3_bucket.s3_bucket_id}/tech-books.csv"

  content_base64 = filebase64("./files/tech-books.csv")
}

module "frontend_s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.0.0"

  bucket = "tech-books-explorer-frontend-bucket-${random_pet.server.id}"

  force_destroy = true

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

# CloudFront

module "cloudfront" {
  source  = "terraform-aws-modules/cloudfront/aws"
  version = "~> 3.2.1"

  comment = "tech-books-explorerフロント用CloudFront"

  enabled         = true
  http_version    = "http2and3"
  is_ipv6_enabled = true
  price_class     = "PriceClass_200"

  create_origin_access_control = true
  origin_access_control = {
    s3_oac = {
      description      = "tech-books-explorerのCloudFrontからS3へのアクセス"
      origin_type      = "s3"
      signing_behavior = "always"
      signing_protocol = "sigv4"
    }
  }

  origin = {
    s3_oac = {
      domain_name           = module.frontend_s3_bucket.s3_bucket_bucket_regional_domain_name
      origin_access_control = "s3_oac"

      custom_header = [
        {
          name  = "X-Forwarded-Scheme"
          value = "https"
        },
        {
          name  = "X-Frame-Options"
          value = "SAMEORIGIN"
        }
      ]
    }
  }

  default_root_object = "index.html"

  default_cache_behavior = {
    target_origin_id       = "s3_oac"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods        = ["GET", "HEAD", "OPTIONS"]
    cached_methods         = ["GET", "HEAD"]
    compress               = true
    query_string           = true
  }

  geo_restriction = {
    restriction_type = "whitelist"
    locations        = ["JP"]
  }

  tags = {
    Terraform   = "true"
    Environment = "staging"
  }
}

# IAM

data "aws_iam_policy_document" "s3_oac_policy" {
  # Origin Access Controls
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${module.frontend_s3_bucket.s3_bucket_arn}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = [module.cloudfront.cloudfront_distribution_arn]
    }
  }
}

# S3バケットポリシー

resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = module.frontend_s3_bucket.s3_bucket_id
  policy = data.aws_iam_policy_document.s3_oac_policy.json
}
