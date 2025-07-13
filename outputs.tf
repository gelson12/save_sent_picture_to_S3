resource "aws_api_gateway_deployment" "dummy_deployment" {
  depends_on  = [aws_api_gateway_integration.dummy_integration]
  rest_api_id = aws_api_gateway_rest_api.dummy_api.id
  stage_name  = "dev"
}

output "api_gateway_invoke_url" {
  value = "${aws_api_gateway_deployment.dummy_deployment.invoke_url}/upload"
}

output "dummy_api_endpoint" {
  value = aws_api_gateway_rest_api.dummy_api.execution_arn
}
