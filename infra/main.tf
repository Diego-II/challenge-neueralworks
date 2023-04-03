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
  ecr_url = module.ecr.ecr_url
}