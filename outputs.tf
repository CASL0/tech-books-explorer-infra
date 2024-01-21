output "dynamodb_arn" {
  description = "ARN of the DynamoDB table"
  value       = module.dynamodb.dynamodb_table_arn
}

output "cloudfront_domain" {
  description = "Domain of the CloudFront"
  value       = module.cloudfront.cloudfront_distribution_domain_name
}
