data "local_file" "account_request_buildspec" {
  filename = "${path.module}/buildspecs/ct-aft-account-request.yml"
}
data "local_file" "account_provisioning_customizations_buildspec" {
  filename = "${path.module}/buildspecs/ct-aft-account-provisioning-customizations.yml"
}

resource "aws_codebuild_project" "account_request" {
  depends_on     = [aws_cloudwatch_log_group.account_request]
  name           = "ct-aft-account-request"
  description    = "Job to apply Terraform for Account Requests"
  build_timeout  = "60"
  service_role   = aws_iam_role.account_request_codebuild_role.arn
  encryption_key = var.aft_key_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.account_request.name
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.codepipeline_s3_bucket_name}/ct-aft-account-request-logs"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = data.local_file.account_request_buildspec.content
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

}

resource "aws_codebuild_project" "account_provisioning_customizations_pipeline" {
  depends_on     = [aws_cloudwatch_log_group.account_request]
  name           = "ct-aft-account-provisioning-customizations"
  description    = "Deploys the Account Provisioning Customizations terraform project"
  build_timeout  = "60"
  service_role   = aws_iam_role.account_provisioning_customizations_codebuild_role.arn
  encryption_key = var.aft_key_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:3.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
  }

  logs_config {
    cloudwatch_logs {
      group_name = aws_cloudwatch_log_group.account_provisioning_customizations.name
    }

    s3_logs {
      status   = "ENABLED"
      location = "${var.codepipeline_s3_bucket_name}/ct-aft-account-provisioning-customization-logs"
    }
  }

  source {
    type      = "CODEPIPELINE"
    buildspec = data.local_file.account_provisioning_customizations_buildspec.content
  }

  vpc_config {
    vpc_id             = var.vpc_id
    subnets            = var.subnet_ids
    security_group_ids = var.security_group_ids
  }

}

resource "aws_cloudwatch_log_group" "account_request" {
  name              = "/aws/codebuild/ct-aft-account-request"
  retention_in_days = var.log_group_retention
}
resource "aws_cloudwatch_log_group" "account_provisioning_customizations" {
  name              = "/aws/codebuild/ct-aft-account-provisioning-customizations"
  retention_in_days = var.log_group_retention
}