# Terraform Dummy AWS Infrastructure

## Overview
Terraform configuration simulating AWS infrastructure (VPC, Lambda, S3, API Gateway) using LocalStack.

## Requirements
- Terraform
- LocalStack (Docker)

## Setup Instructions
1. Start LocalStack:

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
This is a simulated setup using LocalStack endpoints; real AWS resources are not provisioned due to the fact that my current employers(BA) does not permit me to use their infrastructure for testing.




Zip this file as lambda_function_payload.zip:
cd lambda
zip ../lambda_function_payload.zip index.py


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


