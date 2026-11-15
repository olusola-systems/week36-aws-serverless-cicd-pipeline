# GitHub webhook for automatic CodeBuild triggers

resource "aws_codebuild_webhook" "github" {
  project_name    = aws_codebuild_project.serverless_pipeline.name
  manual_creation = true

  filter_group {
    filter {
      type    = "EVENT"
      pattern = "PUSH"
    }

    filter {
      type    = "HEAD_REF"
      pattern = "^refs/heads/main$"
    }

    filter {
      type    = "ACTOR_ACCOUNT_ID"
      pattern = "264746440"
    }
  }
}
