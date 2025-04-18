FROM golang:1.22

# Install Terraform
RUN apt-get update && apt-get install -y unzip wget vim && \
    wget https://releases.hashicorp.com/terraform/1.6.6/terraform_1.6.6_linux_amd64.zip && \
    unzip terraform_1.6.6_linux_amd64.zip && mv terraform /usr/local/bin/

# Set working directory
WORKDIR /app/test

# Copy full repo so tests can access /examples
COPY . /app

# Setup Go
RUN go mod tidy
