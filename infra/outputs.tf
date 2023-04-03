output "ecr_name" {
  description = "Name of the ECR repo with the api."
  value       = module.ecr.ecr_name
  depends_on = [
    module.ecr
  ]
}

output "ecr_url" {
  description = "URL of the ECR repo with the api."
  value       = module.ecr.ecr_url
  depends_on = [
    module.ecr
  ]
}