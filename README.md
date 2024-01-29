# tech-books-explorer-infra
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.21 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.33.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_cloudfront"></a> [cloudfront](#module\_cloudfront) | terraform-aws-modules/cloudfront/aws | ~> 3.2.1 |
| <a name="module_frontend_s3_bucket"></a> [frontend\_s3\_bucket](#module\_frontend\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket_policy.frontend_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [random_pet.server](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |
| [aws_iam_policy_document.s3_oac_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamodb_attributes"></a> [dynamodb\_attributes](#input\_dynamodb\_attributes) | n/a | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "title",<br>    "type": "S"<br>  },<br>  {<br>    "name": "published_at",<br>    "type": "S"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_domain"></a> [cloudfront\_domain](#output\_cloudfront\_domain) | Domain of the CloudFront |
<!-- END_TF_DOCS -->