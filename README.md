# Terraform Dummy AWS Infrastructure

## Overview
Terraform configuration simulating AWS infrastructure (VPC, Lambda, S3, API Gateway) using LocalStack.

## Requirements
- Terraform
- LocalStack (Docker)

## Setup Instructions
1. Start LocalStack:
```shell
docker run -d -p 4566:4566 localstack/localstack


├── main.tf                       # Terraform infrastructure configuration (your provided code)
├── lambda_function_payload.zip   # Zipped Lambda function code (to be created)
├── lambda/
│   └── index.py                  # Python Lambda function handler
├── iam.tf                        # IAM roles and policies (suggested improvements)
├── logging.tf                    # CloudWatch Logs configuration (suggested improvement)
├── outputs.tf                    # Terraform outputs (can separate from main.tf if desired)
├── variables.tf                  # Optional variables (e.g., region, bucket names)
└── README.md       

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
This is a simulated setup using LocalStack endpoints; real AWS resources are not provisioned.




Zip this file as lambda_function_payload.zip:
cd lambda
zip ../lambda_function_payload.zip index.py