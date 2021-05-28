# hello-world-apprunner

AWS App Runner example application

## Usage

1. Create a connection with GitHub in the App Runner console
2. Enter the arn of the GitHub connection in apprunner.tf
3. Run `terraform init` and `terraform apply` to deploy the application

> Note: currently a bug in App Runner prevents Terraform from properly creating the GitHub connection, thus it has been commented out.

## Running in Docker

```
docker build -t hello-world .
docker run -p 8000:8000 --rm hello-world
```