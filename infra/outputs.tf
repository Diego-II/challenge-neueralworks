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

output "lambda_invoke_arn" {
  value = module.lambda.invoke_arn
  depends_on = [
    module.lambda
  ]
}

output "lambda_name" {
  value = module.lambda.lambda_name
  depends_on = [
    module.lambda
  ]
}

output "api_execution_arn" {
  value = module.api-gateway.api_execution_arn
}

output "api_invoke_url" {
  value = module.api-gateway.api_invoke_url
}