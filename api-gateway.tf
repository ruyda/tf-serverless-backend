locals {
  domain_name = split(".", var.domain)[0] // ex: google.com -> google
  openapi3_template_json = jsondecode(file(var.openapi3_template_json_path))
}

resource "aws_api_gateway_rest_api" "backend_api" {
  name = "${local.domain_name}-site-api"
  body = local.openapi3_template_json

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "backend_api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.backend_api.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.backend_api.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "api_stage" {
  deployment_id = aws_api_gateway_deployment.backend_api_deployment.id
  rest_api_id   = aws_api_gateway_rest_api.backend_api.id
  stage_name    = "v0.0.1-backend-api"
}

resource "aws_api_gateway_domain_name" "custom_domain" {
  count                    = var.domain != null ? 1 : 0
  domain_name              = "${var.api_subdomain}.${var.domain}"
  regional_certificate_arn = var.acm_ssl_certificate_arn

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_route53_record" "api_dns_record" {
  count   = var.domain != null && var.route_53_hosted_zone_id != null ? 1 : 0
  name    = aws_api_gateway_domain_name.custom_domain[0].domain_name
  type    = "A"
  zone_id = var.route_53_hosted_zone_id

  alias {
    evaluate_target_health = true
    name                   = aws_api_gateway_domain_name.custom_domain[0].regional_domain_name
    zone_id                = aws_api_gateway_domain_name.custom_domain[0].regional_zone_id
  }
}