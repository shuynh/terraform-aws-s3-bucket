.PHONY: test build-terratest terratest

test:
	bash test/test.sh

build-terratest:
	docker build -f test/Dockerfile -t terratest-s3 .

terratest:
	docker run --rm -it \
		-e AWS_ACCESS_KEY_ID=$$(aws configure get aws_access_key_id --profile testing) \
		-e AWS_SECRET_ACCESS_KEY=$$(aws configure get aws_secret_access_key --profile testing) \
		-e AWS_DEFAULT_REGION=us-east-1 \
		-v "$$(pwd)":/app \
		-w /app/test \
		terratest-s3 go test -v
