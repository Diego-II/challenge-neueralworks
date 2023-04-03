output "ecr_arn" {
  description = "ARN of the ECR repo with the api."
  value = aws_ecr_repository.ecr_repo.arn
}

output "ecr_name" {
  description = "Name of the ECR repo with the api."
  value = aws_ecr_repository.ecr_repo.name
}

output "ecr_url" {
  description = "ECR url"
  value = aws_ecr_repository.ecr_repo.repository_url
}