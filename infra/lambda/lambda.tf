resource aws_lambda_function model-api-lambda {
  count = length(var.lambda_names)
  function_name = element(var.lambda_names, count.index)
  role = aws_iam_role.lambda-role.arn
  memory_size = 3008 
  timeout = 10
  image_uri = join(":", [
    var.ecr_url[count.index],
    "latest"
  ])
  package_type = "Image"
}