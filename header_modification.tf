# https://developers.cloudflare.com/rules/transform/request-header-modification/
resource "cloudflare_ruleset" "transform_modify_request_headers" {
  zone_id     = var.cloudflare_zone_id
  name        = "Request Headers"
  description = "Request Headers"
  kind        = "zone"
  phase       = "http_request_late_transform"

  rules {
    action = "rewrite"
    action_parameters {
      headers {
        name       = "X-ASN"
        operation  = "set"
        expression = "to_string(ip.geoip.asnum)"
      }
    }
    expression  = "true"
    description = "Add ASN to request headers"
    enabled     = true
  }
}

# https://developers.cloudflare.com/rules/transform/response-header-modification/
resource "cloudflare_ruleset" "transform_modify_response_headers" {
  zone_id     = var.cloudflare_zone_id
  name        = "Response Headers"
  description = "Response Headers"
  kind        = "zone"
  phase       = "http_response_headers_transform"

  rules {
    action = "rewrite"
    action_parameters {
      headers {
        name       = "X-ASN"
        operation  = "set"
        expression = "to_string(ip.geoip.asnum)"
      }
    }
    expression  = "(http.host contains \"httpbin\")"
    description = "Add response headers to httpbin"
    enabled     = true
  }

}
