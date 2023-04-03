variable "lambda_name" {
    type = string
    description = "lambda names."
}

variable "lambda_invoke_arn" {
    type = string
    description = "lambda invoke arn."
}

variable "stage" {
    type = string
    description = "stages."
}

variable "api_gateway_name" {
    type = string
    description = "api gateway name."
}