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
  stage = "prd"
  lambda_name = module.lambda.lambda_name[1]
  lambda_invoke_arn = module.lambda.invoke_arn[1]
  depends_on = [
    module.ecr,
    module.lambda
  ]
}