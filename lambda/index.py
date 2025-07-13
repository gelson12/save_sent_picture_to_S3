import boto3
import os
import base64

def handler(event, context):
    s3 = boto3.client('s3', endpoint_url="http://localhost:4566")
    bucket_name = os.environ['BUCKET_NAME']

    image_data = base64.b64decode(event['body'])
    s3.put_object(Bucket=bucket_name, Key='uploaded_image.jpg', Body=image_data)

    return {
        'statusCode': 200,
        'body': 'Image uploaded successfully.'
    }
