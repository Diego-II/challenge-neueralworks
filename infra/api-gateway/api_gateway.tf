resource "aws_api_gateway_rest_api" "api-gateway" {
  name = var.api_gateway_name
}

resource "aws_api_gateway_deployment" "api-gateway" {
  rest_api_id = aws_api_gateway_rest_api.api-gateway.id
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api-gateway" {
  deployment_id = aws_api_gateway_deployment.api-gateway.id
  rest_api_id   = aws_api_gateway_rest_api.api-gateway.id
  count = length(var.stages)
  stage_name    = element(var.stages, count.index)
}

resource "aws_lambda_permission" "apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  count = length(var.lambda_names)
  function_name = var.lambda_names[count.index]
  principal     = "apigateway.amazonaws.com"
  source_arn = join("", [
    aws_api_gateway_rest_api.api-gateway.execution_arn,
    "/*/",
    aws_api_gateway_method.get-prediction-method.http_method,
    aws_api_gateway_resource.get-prediction-resource.path
  ])
}