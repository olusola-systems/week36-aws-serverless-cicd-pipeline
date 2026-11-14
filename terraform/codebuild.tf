# AWS CodeBuild project

resource "aws_codebuild_project" "serverless_pipeline" {

  name         = "week36-serverless-cicd-build"
  description  = "Build and test Week 36 serverless application"
  service_role = aws_iam_role.codebuild.arn

  artifacts {
    type = "S3"

    location = aws_s3_bucket.artifacts.bucket

    name = "deployment.zip"

    packaging = "NONE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"

    image = "aws/codebuild/standard:7.0"

    type = "LINUX_CONTAINER"

    image_pull_credentials_type = "CODEBUILD"
  }

  source {
    type     = "GITHUB"
    location = "https://github.com/olusola-systems/week36-aws-serverless-cicd-pipeline.git"

    buildspec = "buildspec.yml"

    git_clone_depth = 1
  }

  source_version = "refs/heads/main"

  tags = {
    Name    = "Week36-Serverless-CodeBuild"
    Project = "Week36"
  }

}
