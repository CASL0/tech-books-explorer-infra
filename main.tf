provider "aws" {
  region = "ap-northeast-1"
}

resource "random_pet" "server" {
  length = 1
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
