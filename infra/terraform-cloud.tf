locals {
  aws_account_id = "816392071775"
}

terraform {
  cloud {
    organization = "diego-ii"
    workspaces {
      name = "challenge-neueralworks"
    }
  }
}

provider "aws" {
  allowed_account_ids = [local.aws_account_id]
  region              = "us-east-1"
  assume_role {
    role_arn = "arn:aws:iam::${local.aws_account_id}:role/terraform-cloud"
  }
}