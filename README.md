# terraform-aws-s3-bucket

A reusable Terraform module to provision an S3 bucket with:

- KMS encryption
- Optional logging
- Optional versioning
- Consistent tagging
- ...and tests!

## Usage

```hcl
module "s3_bucket" {
  source            = "path/to/module"
  name              = "my-cool-bucket-name"
  logging_bucket    = "my-logging-bucket"
  versioning_enabled = true
  tags = {
    Env = "qa"
  }
}
```

## Inputs

| Name              | Description                        | Type         | Default |
|-------------------|------------------------------------|--------------|---------|
| `name`            | Bucket name                        | `string`     | n/a     |
| `logging_bucket`  | Optional bucket for logs           | `string`     | `null`  |
| `versioning_enabled` | Enable versioning               | `bool`       | `true`  |
| `tags`            | Tags for resources                 | `map(string)`| `{}`    |
| `force_destroy`   | Allow deleting non-empty buckets   | `bool`       | `false` |

## Outputs

| Name          | Description                    |
|---------------|--------------------------------|
| `bucket_name` | Name of the bucket             |
| `bucket_arn`  | ARN of the bucket              |
| `kms_key_arn` | ARN of the KMS key used        |


##  Testing

This module supports both Bash-based and Terratest-based testing.

### Prerequisite

You must have an AWS CLI profile named `testing` configured in `~/.aws/config` or `~/.aws/credentials`.

```ini
# ~/.aws/config
[profile testing]
region = us-east-1
```
### 🔧 Run Tests with Make

```bash
make test            # Runs test/test.sh - Bash + Terraform + AWS CLI
make build-terratest # Builds the Terratest Docker container
make terratest       # Runs Go-based Terratest suite in Docker using AWS_PROFILE=me

