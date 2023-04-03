resource "aws_api_gateway_resource" "get-prediction-resource" {
  path_part   = "get-prediction"
  parent_id   = aws_api_gateway_rest_api.api-gateway.root_resource_id
  rest_api_id = aws_api_gateway_rest_api.api-gateway.id
}

resource "aws_api_gateway_method" "get-prediction-method" {
  rest_api_id   = aws_api_gateway_rest_api.api-gateway.id
  resource_id   = aws_api_gateway_resource.get-prediction-resource.id
  api_key_required = true
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "get-prediction-integration" {
  rest_api_id             = aws_api_gateway_rest_api.api-gateway.id
  resource_id             = aws_api_gateway_resource.get-prediction-resource.id
  http_method             = aws_api_gateway_method.get-prediction-method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_invoke_arn
  depends_on = [aws_api_gateway_method.get-prediction-method]
}