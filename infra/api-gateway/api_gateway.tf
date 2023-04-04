resource "aws_api_gateway_rest_api" "api-gateway" {
  name = var.api_gateway_name
}

resource "aws_api_gateway_deployment" "api-gateway" {
  rest_api_id = aws_api_gateway_rest_api.api-gateway.id
  lifecycle {
    create_before_destroy = true
  }
  depends_on = [
    aws_api_gateway_integration.get-prediction-integration,
  ]
}

resource "aws_api_gateway_stage" "api-gateway" {
  deployment_id = aws_api_gateway_deployment.api-gateway.id
  rest_api_id   = aws_api_gateway_rest_api.api-gateway.id
  stage_name    = var.stage
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "apigateway.amazonaws.com"
  source_arn = join("", [
    aws_api_gateway_rest_api.api-gateway.execution_arn,
    "/*/",
    aws_api_gateway_method.get-prediction-method.http_method,
    aws_api_gateway_resource.model_name.path
  ])
}