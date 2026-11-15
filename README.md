
## Automated CI/CD

GitHub pushes to the main branch trigger AWS CodeBuild.
CodeBuild runs unit tests, packages the Lambda application,
deploys the updated code, and uploads the artifact to S3.

