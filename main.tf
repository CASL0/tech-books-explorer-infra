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
