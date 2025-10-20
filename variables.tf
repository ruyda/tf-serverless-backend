variable "domain" {
  type        = string
  default     = null
  description = "(optional) a domain to associate the API gateway with (excluding http(s)://www.); example: google.com; if no value is given, no domain is associated"
}

variable "api_subdomain" {
  type        = string
  default     = "api"
  description = "(optional) the subdomain used to route requests to the API gateway; example: api.google.com; requires `domain` variable to have a value"
}

variable "route_53_hosted_zone_id" {
  type        = string
  default     = null
  description = "(optional) the Route 53 hosted zone ID where an `api.` subdomain will be registered; requires `domain` variable to have a value"
}

variable "acm_ssl_certificate_arn" {
  type        = string
  default     = null
  description = "(optional; required if `domain` has a value) ARN of the ACM SSL certificate associated with the given domain; requires `domain` variable to have a value"
}

variable "openapi3_template_json_path" {
  type        = string
  description = "the string path/to/template.json relative to this module's reference location"
}