
# IMPORTANT NOTES:
#
# - Dummy credentials used for local testing only.
# - IAM roles, policies, endpoints, and credentials MUST be modified for actual deployments in a real AWS environment.
# - Ensure endpoints point to actual AWS service URLs and remove localstack endpoint URLs for production use.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "dummy"
  secret_key                  = "dummy"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  endpoints {
    lambda     = "http://localhost:4566"
    s3         = "http://localhost:4566"
    apigateway = "http://localhost:4566"
    ec2        = "http://localhost:4566"
  }
}

resource "aws_vpc" "dummy_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "DummyVPC" }
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.dummy_vpc.id
  cidr_block = "10.0.1.0/24"
  tags = { Name = "PrivateSubnet" }
}

resource "aws_security_group" "lambda_sg" {
  name        = "lambda_sg"
  description = "Allow Lambda access"
  vpc_id      = aws_vpc.dummy_vpc.id

  ingress { protocol = "-1"; from_port = 0; to_port = 0; cidr_blocks = ["10.0.0.0/16"] }
  egress  { protocol = "-1"; from_port = 0; to_port = 0; cidr_blocks = ["0.0.0.0/0"] }
}

resource "aws_s3_bucket" "dummy_bucket" {
  bucket = "dummy-s3-bucket"
}

resource "aws_lambda_function" "dummy_lambda" {
  function_name = "dummy_lambda"
  handler       = "index.handler"
  runtime       = "python3.9"
  role          = aws_iam_role.dummy_lambda_role.arn
  filename      = "lambda_function_payload.zip"

  vpc_config {
    subnet_ids         = [aws_subnet.private_subnet.id]
    security_group_ids = [aws_security_group.lambda_sg.id]
  }

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.dummy_bucket.bucket
    }
  }
}

resource "aws_api_gateway_rest_api" "dummy_api" {
  name        = "dummy_api_gateway"
  description = "Dummy API Gateway"
}

resource "aws_api_gateway_resource" "dummy_resource" {
  rest_api_id = aws_api_gateway_rest_api.dummy_api.id
  parent_id   = aws_api_gateway_rest_api.dummy_api.root_resource_id
  path_part   = "upload"
}

resource "aws_api_gateway_method" "dummy_method" {
  rest_api_id   = aws_api_gateway_rest_api.dummy_api.id
  resource_id   = aws_api_gateway_resource.dummy_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "dummy_integration" {
  rest_api_id             = aws_api_gateway_rest_api.dummy_api.id
  resource_id             = aws_api_gateway_resource.dummy_resource.id
  http_method             = aws_api_gateway_method.dummy_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.dummy_lambda.invoke_arn
}

resource "aws_lambda_permission" "dummy_permission" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.dummy_lambda.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.dummy_api.execution_arn}/*/*/*"
}
