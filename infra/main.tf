module "ecr" {
  source        = "./ecr"
  ecr_names = [
   "challenge-neuralworks-ecr-dev",
   "challenge-neuralworks-ecr-prd",
  ]
}

module "lambda" {
  source        = "./lambda"
  lambda_names = [
   "challenge-neuralworks-lambda-dev",
   "challenge-neuralworks-lambda-prd",
  ]
  depends_on = [
    module.ecr
  ]
  ecr_url = module.ecr.ecr_url
}

module "api-gateway" {
  source = "./api-gateway"
  api_gateway_name = "challenge-neuralworks-api-gateway"
  stages = [
   "dev",
   "prd",
  ]
  lambda_names = module.lambda.lambda_name
  lambda_invoke_arn = module.lambda.invoke_arn
  depends_on = [
    module.ecr,
    module.lambda
  ]
}