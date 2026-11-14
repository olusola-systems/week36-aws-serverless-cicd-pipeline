# IAM role assumed by AWS CodeBuild

resource "aws_iam_role" "codebuild" {

  name = "week36-serverless-codebuild-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "codebuild.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = {

    Name = "Week36-CodeBuild-Role"

    Project = "Week36"

  }

}

# Permissions for CodeBuild

resource "aws_iam_role_policy" "codebuild_permissions" {

  name = "week36-serverless-codebuild-permissions"

  role = aws_iam_role.codebuild.id

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Effect = "Allow"

        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]

        Resource = "*"
      },

      {
        Effect = "Allow"

        Action = [
          "s3:GetBucketLocation",
          "s3:ListBucket"
        ]

        Resource = aws_s3_bucket.artifacts.arn
      },

      {
        Effect = "Allow"

        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]

        Resource = "${aws_s3_bucket.artifacts.arn}/*"
      },
      {
        Effect = "Allow"
        Action = [
          "lambda:UpdateFunctionCode"
        ]
        Resource = "arn:aws:lambda:us-east-1:906446636895:function:week36-serverless-task-processor"
      }

    ]

  })

}
