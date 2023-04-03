module "ecr" {
  source        = "./ecr"
  ecr_names = [
   "challenge-neuralworks-ecr-dev",
    "challenge-neuralworks-ecr-prd",
  ]
}