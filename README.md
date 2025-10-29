# tf-serverless-backend

Currently deploys a given OpenAPI 3.0 template which expects preexisting setup in the AWS console. Eventually will deploy a customizable API gateway with lambda functions serving as a versatile backend.

Reference this module from a `*.tf` file.
```
module "serverless-backend" {
  source                      = "git::https://github.com/ruyda/tf-serverless-backend.git"
  openapi3_template_json_path = "./openapi_template.json"
}
```

### Module inputs

| Name                            | Description                                                                 |
|---------------------------------|-----------------------------------------------------------------------------|
| **openapi_template_json_path**  | The string ./path/to/template.json                                          |
| **domain**                      | (optional) A domain to associate with the API gateway (excluding http(s)://www.); example: google.com              |
| **api_subdomain**               | (optional) (optional) the subdomain used to route requests to the API gateway; required `domain` variable to have a value; default = `api` |
| **acm_ssl_certificate_arn**     | (optional) ARN of the ACM SSL certificate; required if `domain` is provided |
| **route_53_hosted_zone_id**     | (optional) A Route 53 hosted zone to setup API gateway DNS; required if `domain` is provided and a Route 53 domain |

### Module outputs

| Name                        | Description                        |
|-----------------------------|------------------------------------|
| **api_gateway_id**          |                                    |
| **api_gateway_stage_name**  |                                    |
| **api_gateway_domain_name** | `${var.api_subdomain}.{var.domain} |

### Related projects
- S3 static front end to pair with this API gateway back end [ 🔗 view GitHub](https://github.com/ruyda/tf-cloudfront-s3-website)
- (Coming soon) Mnecraft server (1.28) serverless hosting with EC2