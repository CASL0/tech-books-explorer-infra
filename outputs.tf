output "availability_zones" {
  value = data.aws_availability_zones.available.names
}

output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}
