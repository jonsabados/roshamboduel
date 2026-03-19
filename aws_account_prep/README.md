# AWS Account Preparation

This directory contains Terraform configuration for one-time AWS account setup, primarily for GitHub Actions OIDC authentication.

## Prerequisites

- AWS CLI configured with appropriate credentials (SSO or API keys)
- Terraform installed
- S3 bucket for Terraform state already created

## Setup

1. Create a `terraform.tfvars` file (gitignored) with your sensitive values:

```hcl
state_bucket = "your-state-bucket-name"
aws_profile  = "your-aws-profile"
```

2. Initialize Terraform with the state bucket:

```bash
terraform init \
  -backend-config="bucket=your-state-bucket-name" \
  -backend-config="profile=your-aws-profile"
```

> **Note:** If using AWS SSO, you must pass the profile explicitly via `-backend-config`. The S3 backend doesn't reliably pick up the `AWS_PROFILE` environment variable.

3. Apply the configuration:

```bash
terraform apply
```

## What This Creates

- **GitHub OIDC Provider**: Allows GitHub Actions to authenticate without long-lived credentials
- **IAM Role**: `github-actions-roshamboduel-deploy` - assumed by GitHub Actions for deployments
- **IAM Policy**: Grants permissions for Lambda, API Gateway, DynamoDB, S3, CloudFront, Route53, ACM, IAM, CloudWatch, and X-Ray

## GitHub Secrets Required

After applying, configure these secrets in your GitHub repository:

- `AWS_ACCOUNT`: Your AWS account ID
- `STATE_BUCKET`: The S3 bucket name for Terraform state