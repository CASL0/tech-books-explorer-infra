# tech-books-explorer-infra

Tech Books Explorer のインフラです。

## 構成図

![infra](https://github.com/CASL0/tech-books-explorer-infra/assets/28913760/500e73bf-34ac-4a72-b36e-c757a4f43b27)

<!-- BEGIN_TF_DOCS -->

## Requirements

| Name                                                                     | Version |
| ------------------------------------------------------------------------ | ------- |
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.0  |
| <a name="requirement_aws"></a> [aws](#requirement_aws)                   | >= 5.21 |
| <a name="requirement_random"></a> [random](#requirement_random)          | >= 3.0  |

## Providers

| Name                                                      | Version |
| --------------------------------------------------------- | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws)          | 5.33.0  |
| <a name="provider_random"></a> [random](#provider_random) | 3.6.0   |

## Modules

| Name                                                                                      | Source                               | Version  |
| ----------------------------------------------------------------------------------------- | ------------------------------------ | -------- |
| <a name="module_cloudfront"></a> [cloudfront](#module_cloudfront)                         | terraform-aws-modules/cloudfront/aws | ~> 3.2.1 |
| <a name="module_frontend_s3_bucket"></a> [frontend_s3_bucket](#module_frontend_s3_bucket) | terraform-aws-modules/s3-bucket/aws  | ~> 4.0.0 |

## Resources

| Name                                                                                                                                        | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_s3_bucket_policy.frontend_bucket_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource    |
| [random_pet.server](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet)                                     | resource    |
| [aws_iam_policy_document.s3_oac_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name                                                                                       | Description | Type                                                                 | Default                                                                                                                     | Required |
| ------------------------------------------------------------------------------------------ | ----------- | -------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | :------: |
| <a name="input_dynamodb_attributes"></a> [dynamodb_attributes](#input_dynamodb_attributes) | n/a         | <pre>list(object({<br> name = string<br> type = string<br> }))</pre> | <pre>[<br> {<br> "name": "title",<br> "type": "S"<br> },<br> {<br> "name": "published_at",<br> "type": "S"<br> }<br>]</pre> |    no    |

## Outputs

| Name                                                                                   | Description              |
| -------------------------------------------------------------------------------------- | ------------------------ |
| <a name="output_cloudfront_domain"></a> [cloudfront_domain](#output_cloudfront_domain) | Domain of the CloudFront |

<!-- END_TF_DOCS -->
