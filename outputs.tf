
# Outputs
resource "aws_api_gateway_deployment" "dummy_deployment" {
  depends_on  = [aws_api_gateway_integration.dummy_integration]
  rest_api_id = aws_api_gateway_rest_api.dummy_api.id
}

output "api_gateway_invoke_url" {
  value = "http://${aws_api_gateway_rest_api.dummy_api.id}.execute-api.localhost.localstack.cloud:4566/dev/upload"
}

output "dummy_api_endpoint" {
  value = aws_api_gateway_rest_api.dummy_api.execution_arn
}
