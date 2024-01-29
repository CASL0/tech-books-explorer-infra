output "cloudfront_domain" {
  description = "Domain of the CloudFront"
  value       = module.cloudfront.cloudfront_distribution_domain_name
}
