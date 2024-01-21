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
| <a name="provider_random"></a> [random](#provider\_random) | 3.6.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_csv_s3_bucket"></a> [csv\_s3\_bucket](#module\_csv\_s3\_bucket) | terraform-aws-modules/s3-bucket/aws | ~> 4.0.0 |
| <a name="module_dynamodb"></a> [dynamodb](#module\_dynamodb) | terraform-aws-modules/dynamodb-table/aws | ~> 4.0.0 |
| <a name="module_s3_import_object_csv"></a> [s3\_import\_object\_csv](#module\_s3\_import\_object\_csv) | terraform-aws-modules/s3-bucket/aws//modules/object | ~> 4.0.0 |

## Resources

| Name | Type |
|------|------|
| [random_pet.server](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/pet) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dynamodb_attributes"></a> [dynamodb\_attributes](#input\_dynamodb\_attributes) | n/a | <pre>list(object({<br>    name = string<br>    type = string<br>  }))</pre> | <pre>[<br>  {<br>    "name": "title",<br>    "type": "S"<br>  },<br>  {<br>    "name": "published_at",<br>    "type": "S"<br>  }<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dynamodb_arn"></a> [dynamodb\_arn](#output\_dynamodb\_arn) | ARN of the DynamoDB table |
<!-- END_TF_DOCS -->