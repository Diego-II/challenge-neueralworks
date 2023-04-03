output "api_execution_arn" {
  value = aws_api_gateway_rest_api.api-gateway.*.execution_arn
}

output "api_invoke_url" {
  value = aws_api_gateway_stage.api-gateway.*.invoke_url
}