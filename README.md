# Terraform Dummy AWS Infrastructure

## Overview
Terraform configuration simulating AWS infrastructure (VPC, Lambda, S3, API Gateway) using LocalStack.

## Requirements
- Terraform
- LocalStack (Docker)

## Setup Instructions
1. Start LocalStack:

docker run -d -p 4566:4566 localstack/localstack
 

Deploy Terraform:
terraform init
terraform apply


Invoke the Lambda via API Gateway endpoint.


Notes
Dummy credentials used for local testing only.

Modify IAM and endpoints for actual deployments.


Deploy Lambda within a private VPC.

Components:
AWS API Gateway: Simulated endpoint triggers the Lambda.

AWS Lambda Function: Dummy function deployed within private VPC.

AWS S3 Bucket: Dummy storage for data.

Private VPC: Provides secure isolation for Lambda.

Usage Instructions:
Prerequisites: Install Terraform and LocalStack (for local AWS simulation).

Deployment:

terraform init
terraform apply

Verification:
The dummy API Gateway endpoint provided in Terraform outputs simulates the API interaction. Check Terraform outputs after deployment for details.

Security Considerations:
Lambda is deployed within a private subnet.

API Gateway only allows Lambda invocation securely.

Limitations:
This is a simulated setup using LocalStack endpoints; real AWS resources are not provisioned due to the fact that my current employers(BA) does not permit me to use their infrastructure for testing.




Ziping this file as lambda_function_payload.zip:
/mnt/c/Users/Gelson/Downloads/save_sent_picture_to_S3   main ●  cd lambda                12 ↵  Ubu  09:16:14 
/mnt/c/Users/Gelson/Downloads/save_sent_picture_to_S3/lambda   main ●  zip lambda_function_payload.zip index.py 
  adding: index.py (deflated 33%)


Setting up terraform on my local machine
terraform init        1 ↵  Ubu  19:50:19 


Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "~> 5.0"...
- Installing hashicorp/aws v5.100.0...
- Installed hashicorp/aws v5.100.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.


NOTE: once again please note that ill be using LocalStack, and LocalStack needs Docker to deploy Lambda functions, because it uses containers to simulate AWS Lambda.


docker run -d \
  -p 4566:4566 -p 4571:4571 \
  -e SERVICES=lambda,s3,iam,apigateway,ec2 \
  -e DOCKER_HOST=unix:///var/run/docker.sock \
  -v /var/run/docker.sock:/var/run/docker.sock \
  localstack/localstack



  FINAL RESULT:
   /mnt/c/Users/Gelson/Downloads/save_sent_picture_to_S3   main ● ?  terraform apply -auto-approve

aws_vpc.dummy_vpc: Refreshing state... [id=vpc-6f66b5dcc74079ff2]
aws_s3_bucket.dummy_bucket: Refreshing state... [id=dummy-s3-bucket]
aws_iam_role.dummy_lambda_role: Refreshing state... [id=dummy_lambda_role]
aws_api_gateway_rest_api.dummy_api: Refreshing state... [id=5iisi7tpzg]
aws_iam_policy_attachment.lambda_s3_policy_attachment: Refreshing state... [id=lambda_s3_policy_attachment]
aws_security_group.lambda_sg: Refreshing state... [id=sg-368e447cb221e6f93]
aws_subnet.private_subnet: Refreshing state... [id=subnet-8795bd2b20cec05ba]
aws_lambda_function.dummy_lambda: Refreshing state... [id=dummy_lambda]
aws_api_gateway_resource.dummy_resource: Refreshing state... [id=5wzahpzbqu]
aws_api_gateway_method.dummy_method: Refreshing state... [id=agm-5iisi7tpzg-5wzahpzbqu-POST]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have  
affected this plan:

  # aws_api_gateway_method.dummy_method has been deleted
  - resource "aws_api_gateway_method" "dummy_method" {
      - http_method          = "POST" -> null
        id                   = "agm-5iisi7tpzg-5wzahpzbqu-POST"
        # (7 unchanged attributes hidden)
    }

  # aws_api_gateway_resource.dummy_resource has been deleted
  - resource "aws_api_gateway_resource" "dummy_resource" {
      - id          = "5wzahpzbqu" -> null
        # (4 unchanged attributes hidden)
    }

  # aws_api_gateway_rest_api.dummy_api has been deleted
  - resource "aws_api_gateway_rest_api" "dummy_api" {
      - execution_arn                = "arn:aws:execute-api:us-east-1::5iisi7tpzg" -> null
      - id                           = "5iisi7tpzg" -> null
        name                         = "dummy_api_gateway"
      - root_resource_id             = "ia6t5m08lh" -> null
        tags                         = {}
        # (7 unchanged attributes hidden)

        # (1 unchanged block hidden)
    }

  # aws_iam_role.dummy_lambda_role has been deleted
  - resource "aws_iam_role" "dummy_lambda_role" {
      - arn                   = "arn:aws:iam::000000000000:role/dummy_lambda_role" -> null
        id                    = "dummy_lambda_role"
      - name                  = "dummy_lambda_role" -> null
        tags                  = {}
        # (8 unchanged attributes hidden)
    }

  # aws_lambda_function.dummy_lambda has been deleted
  - resource "aws_lambda_function" "dummy_lambda" {
      - function_name                  = "dummy_lambda" -> null
        id                             = "dummy_lambda"
        # (10 unchanged attributes hidden)

        # (2 unchanged blocks hidden)
    }

  # aws_s3_bucket.dummy_bucket has been deleted
  - resource "aws_s3_bucket" "dummy_bucket" {
      - bucket                      = "dummy-s3-bucket" -> null
        id                          = "dummy-s3-bucket"
        tags                        = {}
        # (9 unchanged attributes hidden)

        # (3 unchanged blocks hidden)
    }

  # aws_security_group.lambda_sg has been deleted
  - resource "aws_security_group" "lambda_sg" {
      - id                     = "sg-368e447cb221e6f93" -> null
        name                   = "lambda_sg"
        tags                   = {}
        # (8 unchanged attributes hidden)
    }

  # aws_subnet.private_subnet has been deleted
  - resource "aws_subnet" "private_subnet" {
      - id                                             = "subnet-8795bd2b20cec05ba" -> null
        tags                                           = {
            "Name" = "PrivateSubnet"
        }
        # (16 unchanged attributes hidden)
    }

  # aws_vpc.dummy_vpc has been deleted
  - resource "aws_vpc" "dummy_vpc" {
      - id                                   = "vpc-6f66b5dcc74079ff2" -> null
        tags                                 = {
            "Name" = "DummyVPC"
        }
        # (15 unchanged attributes hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using
ignore_changes, the following plan may include actions to undo or respond to these changes.

─────────────────────────────────────────────────────────────────────────────────────────────────────────────────── 

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with 
the following symbols:
  + create

Terraform will perform the following actions:

  # aws_api_gateway_deployment.dummy_deployment will be created
  + resource "aws_api_gateway_deployment" "dummy_deployment" {
      + created_date  = (known after apply)
      + execution_arn = (known after apply)
      + id            = (known after apply)
      + invoke_url    = (known after apply)
      + rest_api_id   = (known after apply)
    }

  # aws_api_gateway_integration.dummy_integration will be created
  + resource "aws_api_gateway_integration" "dummy_integration" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "POST"
      + id                      = (known after apply)
      + integration_http_method = "POST"
      + passthrough_behavior    = (known after apply)
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "AWS_PROXY"
      + uri                     = (known after apply)
    }

  # aws_api_gateway_method.dummy_method will be created
  + resource "aws_api_gateway_method" "dummy_method" {
      + api_key_required = false
      + authorization    = "NONE"
      + http_method      = "POST"
      + id               = (known after apply)
      + resource_id      = (known after apply)
      + rest_api_id      = (known after apply)
    }

  # aws_api_gateway_resource.dummy_resource will be created
  + resource "aws_api_gateway_resource" "dummy_resource" {
      + id          = (known after apply)
      + parent_id   = (known after apply)
      + path        = (known after apply)
      + path_part   = "upload"
      + rest_api_id = (known after apply)
    }

  # aws_api_gateway_rest_api.dummy_api will be created
  + resource "aws_api_gateway_rest_api" "dummy_api" {
      + api_key_source               = (known after apply)
      + arn                          = (known after apply)
      + binary_media_types           = (known after apply)
      + created_date                 = (known after apply)
      + description                  = "Dummy API Gateway"
      + disable_execute_api_endpoint = (known after apply)
      + execution_arn                = (known after apply)
      + id                           = (known after apply)
      + minimum_compression_size     = (known after apply)
      + name                         = "dummy_api_gateway"
      + policy                       = (known after apply)
      + root_resource_id             = (known after apply)
      + tags_all                     = (known after apply)
    }

  # aws_iam_policy_attachment.lambda_s3_policy_attachment will be created
  + resource "aws_iam_policy_attachment" "lambda_s3_policy_attachment" {
      + id         = (known after apply)
      + name       = "lambda_s3_policy_attachment"
      + policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
      + roles      = [
          + "dummy_lambda_role",
        ]
    }

  # aws_iam_role.dummy_lambda_role will be created
  + resource "aws_iam_role" "dummy_lambda_role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "lambda.amazonaws.com"
                        }
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "dummy_lambda_role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)
    }

  # aws_lambda_function.dummy_lambda will be created
  + resource "aws_lambda_function" "dummy_lambda" {
      + architectures                  = (known after apply)
      + arn                            = (known after apply)
      + code_sha256                    = (known after apply)
      + filename                       = "./lambda/lambda_function_payload.zip"
      + function_name                  = "dummy_lambda"
      + handler                        = "index.handler"
      + id                             = (known after apply)
      + invoke_arn                     = (known after apply)
      + last_modified                  = (known after apply)
      + memory_size                    = 128
      + package_type                   = "Zip"
      + publish                        = false
      + qualified_arn                  = (known after apply)
      + qualified_invoke_arn           = (known after apply)
      + reserved_concurrent_executions = -1
      + role                           = (known after apply)
      + runtime                        = "python3.9"
      + signing_job_arn                = (known after apply)
      + signing_profile_version_arn    = (known after apply)
      + skip_destroy                   = false
      + source_code_hash               = (known after apply)
      + source_code_size               = (known after apply)
      + tags_all                       = (known after apply)
      + timeout                        = 3
      + version                        = (known after apply)

      + environment {
          + variables = {
              + "BUCKET_NAME" = "dummy-s3-bucket"
            }
        }

      + vpc_config {
          + ipv6_allowed_for_dual_stack = false
          + security_group_ids          = (known after apply)
          + subnet_ids                  = (known after apply)
          + vpc_id                      = (known after apply)
        }
    }

  # aws_lambda_permission.dummy_permission will be created
  + resource "aws_lambda_permission" "dummy_permission" {
      + action              = "lambda:InvokeFunction"
      + function_name       = "dummy_lambda"
      + id                  = (known after apply)
      + principal           = "apigateway.amazonaws.com"
      + source_arn          = (known after apply)
      + statement_id        = "AllowAPIGatewayInvoke"
      + statement_id_prefix = (known after apply)
    }

  # aws_s3_bucket.dummy_bucket will be created
  + resource "aws_s3_bucket" "dummy_bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "dummy-s3-bucket"
      + bucket_domain_name          = (known after apply)
      + bucket_prefix               = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
    }

  # aws_security_group.lambda_sg will be created
  + resource "aws_security_group" "lambda_sg" {
      + arn                    = (known after apply)
      + description            = "Allow Lambda access"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "10.0.0.0/16",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + name                   = "lambda_sg"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # aws_subnet.private_subnet will be created
  + resource "aws_subnet" "private_subnet" {
      + arn                                            = (known after apply)
      + assign_ipv6_address_on_creation                = false
      + availability_zone                              = (known after apply)
      + availability_zone_id                           = (known after apply)
      + cidr_block                                     = "10.0.1.0/24"
      + enable_dns64                                   = false
      + enable_resource_name_dns_a_record_on_launch    = false
      + enable_resource_name_dns_aaaa_record_on_launch = false
      + id                                             = (known after apply)
      + ipv6_cidr_block_association_id                 = (known after apply)
      + ipv6_native                                    = false
      + map_public_ip_on_launch                        = false
      + owner_id                                       = (known after apply)
      + private_dns_hostname_type_on_launch            = (known after apply)
      + tags                                           = {
          + "Name" = "PrivateSubnet"
        }
      + tags_all                                       = {
          + "Name" = "PrivateSubnet"
        }
      + vpc_id                                         = (known after apply)
    }

  # aws_vpc.dummy_vpc will be created
  + resource "aws_vpc" "dummy_vpc" {
      + arn                                  = (known after apply)
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = (known after apply)
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "DummyVPC"
        }
      + tags_all                             = {
          + "Name" = "DummyVPC"
        }
    }

Plan: 13 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  ~ api_gateway_invoke_url = "http://5iisi7tpzg.execute-api.localhost.localstack.cloud:4566/dev/upload" -> (known after apply)
  ~ dummy_api_endpoint     = "arn:aws:execute-api:us-east-1::5iisi7tpzg" -> (known after apply)
aws_vpc.dummy_vpc: Creating...
aws_iam_role.dummy_lambda_role: Creating...
aws_api_gateway_rest_api.dummy_api: Creating...
aws_s3_bucket.dummy_bucket: Creating...
aws_iam_role.dummy_lambda_role: Creation complete after 0s [id=dummy_lambda_role]
aws_iam_policy_attachment.lambda_s3_policy_attachment: Creating...
aws_iam_policy_attachment.lambda_s3_policy_attachment: Creation complete after 0s [id=lambda_s3_policy_attachment]
aws_s3_bucket.dummy_bucket: Creation complete after 0s [id=dummy-s3-bucket]
aws_vpc.dummy_vpc: Creation complete after 0s [id=vpc-5c09d2703b5d2a00b]
aws_api_gateway_rest_api.dummy_api: Creation complete after 0s [id=7vcz2cp7r8]
aws_subnet.private_subnet: Creating...
aws_security_group.lambda_sg: Creating...
aws_api_gateway_resource.dummy_resource: Creating...
aws_api_gateway_resource.dummy_resource: Creation complete after 0s [id=ecn8mgneyi]
aws_api_gateway_method.dummy_method: Creating...
aws_api_gateway_method.dummy_method: Creation complete after 0s [id=agm-7vcz2cp7r8-ecn8mgneyi-POST]
aws_subnet.private_subnet: Creation complete after 0s [id=subnet-fdee6d07405abc9a7]
aws_security_group.lambda_sg: Creation complete after 1s [id=sg-fa689ef578a4f33c2]
aws_lambda_function.dummy_lambda: Creating...
aws_lambda_function.dummy_lambda: Still creating... [10s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [20s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [30s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [40s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [50s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [1m0s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [1m10s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [1m20s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [1m30s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [1m40s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [1m50s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [2m0s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [2m10s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [2m20s elapsed]
aws_lambda_function.dummy_lambda: Still creating... [2m30s elapsed]
aws_lambda_function.dummy_lambda: Creation complete after 2m38s [id=dummy_lambda]
aws_lambda_permission.dummy_permission: Creating...
aws_api_gateway_integration.dummy_integration: Creating...
aws_lambda_permission.dummy_permission: Creation complete after 0s [id=AllowAPIGatewayInvoke]
aws_api_gateway_integration.dummy_integration: Creation complete after 0s [id=agi-7vcz2cp7r8-ecn8mgneyi-POST]
aws_api_gateway_deployment.dummy_deployment: Creating...
aws_api_gateway_deployment.dummy_deployment: Creation complete after 0s [id=yfzjoip0eq]

Apply complete! Resources: 13 added, 0 changed, 0 destroyed.

Outputs:

api_gateway_invoke_url = "http://7vcz2cp7r8.execute-api.localhost.localstack.cloud:4566/dev/upload"
dummy_api_endpoint = "arn:aws:execute-api:us-east-1::7vcz2cp7r8"