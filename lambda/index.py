import boto3
import os
import base64

def handler(event, context):
    s3 = boto3.client('s3', endpoint_url="http://localhost:4566")
    bucket_name = os.environ['BUCKET_NAME']
