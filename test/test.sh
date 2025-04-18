#!/bin/bash
set -e

BUCKET_NAME="test-$(date +%s)"

terraform -chdir=examples init

echo "🚀 Creating bucket: $BUCKET_NAME"
AWS_PROFILE=testing terraform -chdir=examples apply -auto-approve -var="name=$BUCKET_NAME"

AWS_PROFILE=testing aws s3api head-bucket --bucket "$BUCKET_NAME"
echo "✅ Bucket $BUCKET_NAME exists"

AWS_PROFILE=testing terraform -chdir=examples destroy -auto-approve -var="name=$BUCKET_NAME"
echo "🧹 Bucket $BUCKET_NAME destroyed"
