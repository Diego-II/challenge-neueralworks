variable "lambda_names" {
    type = list(string)
    description = "lambda names."
}

variable "lambda_invoke_arn" {
    type = list(string)
    description = "lambda invoke arn."
}

variable "stages" {
    type = list(string)
    description = "stages."
}

variable "api_gateway_name" {
    type = string
    description = "api gateway name."
}