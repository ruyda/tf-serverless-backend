# tf-serverless-backend

Currently deploys a given OpenAPI 3.0 template which expects preexisting setup in the AWS console. Eventually will deploy a customizable API gateway with lambda functions serving as a versatile backend.

Reference this module from a `*.tf` file.
```
module "serverless-backend" {
  source                      = "git::https://github.com/ruyda/tf-serverless-backend.git"
  openapi3_template_json_path = "./openapi_template.json"
}
```

### Variable inputs

| Name                        | Description                                                                     |
|-----------------------------|---------------------------------------------------------------------------------|
| **openapi_template_json_path** | The string ./path/to/template.json                                          |
| **domain**                      | (optional) A domain to associate with the API gateway (excluding http(s)://www.); example: google.com               |
| **acm_ssl_certificate_arn**     | (optional) ARN of the ACM SSL certificate; required if `domain` is provided |
| **route_53_hosted_zone_id**     | (optional) A Route 53 hosted zone to setup API gateway DNS; required if `domain` is provided and a Route 53 domain |

### Module outputs

TODO

### Related projects
- S3 static front end to pair with this API gateway back end [ 🔗 view GitHub](https://github.com/ruyda/tf-cloudfront-s3-website)
- (Coming soon) Mnecraft server (1.28) serverless hosting with EC2