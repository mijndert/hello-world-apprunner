terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-west-1"
}

# resource "aws_apprunner_connection" "hello-world" {
#   connection_name = "hello-world-apprunner-connection"
#   provider_type       = "GITHUB"
#   tags = {
#     Name = "hello-world-apprunner-connection"
#   }
# }

resource "aws_apprunner_auto_scaling_configuration_version" "hello-world" {
  auto_scaling_configuration_name = "hello-world"
  max_concurrency                 = 200
  max_size                        = 10
  min_size                        = 2

  tags = {
    Name = "hello-world"
  }
}

resource "aws_apprunner_service" "hello-world-service" {
  auto_scaling_configuration_arn = aws_apprunner_auto_scaling_configuration_version.hello-world.arn

  service_name = "example"

  source_configuration {
    authentication_configuration {
      #connection_arn = aws_apprunner_connection.hello-world.arn
    }

    code_repository {
      code_configuration {
        configuration_source = "API"

        code_configuration_values {
          runtime       = "PYTHON_3"
          build_command = "pip install -r requirements.txt"
          start_command = "python app.py"
          port          = "8000"
        }
      }

      repository_url = "https://github.com/mijndert/hello-world-apprunner"

      source_code_version {
        type  = "BRANCH"
        value = "main"
      }

    }
  }
  tags = {
    Name = "hello-world-service"
  }
}