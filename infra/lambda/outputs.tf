output "lambda_name" {
  value = aws_lambda_function.model-api-lambda.*.function_name
}

output "invoke_arn" {
  value = aws_lambda_function.model-api-lambda.*.invoke_arn
}

output "name" {
  value = aws_lambda_function.model-api-lambda.*.function_name
}