resource "aws_ecr_repository" "ecr_inference_api_repo" {
  count = length(var.ecr_names)
  name  = element(var.ecr_names, count.index)
}

resource "aws_ecr_repository_policy" "ecr-repo-policy" {
  count = length(var.ecr_names)
  repository = aws_ecr_repository.ecr_inference_api_repo[count.index].name
  policy     = <<EOF
  {
    "Version": "2008-10-17",
    "Statement": [
      {
        "Sid": "adds full ecr access to the inference api repository",
        "Effect": "Allow",
        "Principal": "*",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:BatchGetImage",
          "ecr:CompleteLayerUpload",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetLifecyclePolicy",
          "ecr:InitiateLayerUpload",
          "ecr:PutImage",
          "ecr:UploadLayerPart"
        ]
      }
    ]
  }
  EOF
}