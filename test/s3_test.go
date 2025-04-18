package test

import (
  "fmt"
  "testing"
  "time"

  awsSDK "github.com/aws/aws-sdk-go/aws"
  "github.com/aws/aws-sdk-go/aws/session"
  "github.com/aws/aws-sdk-go/service/s3"
  "github.com/gruntwork-io/terratest/modules/terraform"
  terratestAws "github.com/gruntwork-io/terratest/modules/aws"
  "github.com/stretchr/testify/assert"
)

func TestS3Module(t *testing.T) {
  t.Parallel()

  region := "us-east-1"
  bucketName := fmt.Sprintf("terratest-%d", time.Now().Unix())

  terraformOptions := &terraform.Options{
    TerraformDir: "../examples",
    Vars: map[string]interface{}{
      "name": bucketName,
    },
  }

  defer terraform.Destroy(t, terraformOptions)
  terraform.InitAndApply(t, terraformOptions)

  // Validate the bucket exists using AWS SDK
  sess, err := session.NewSession(&awsSDK.Config{Region: awsSDK.String(region)})
  assert.NoError(t, err)

  s3Client := s3.New(sess)
  _, err = s3Client.HeadBucket(&s3.HeadBucketInput{Bucket: awsSDK.String(bucketName)})
  assert.NoError(t, err, "Expected bucket %s to exist", bucketName)

  // Validate versioning with Terratest
  versioning := terratestAws.GetS3BucketVersioning(t, region, bucketName)
  assert.Equal(t, "Enabled", versioning)
}
