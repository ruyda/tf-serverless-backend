output "api_gateway_id" {
  value = aws_api_gateway_rest_api.backend_api.id
}

output "api_gateway_stage_name" {
  value = aws_api_gateway_stage.api_stage.stage_name
}

output "api_gateway_domain_name" {
  value = var.domain != null ? aws_api_gateway_domain_name.custom_domain[0].domain_name : null
}