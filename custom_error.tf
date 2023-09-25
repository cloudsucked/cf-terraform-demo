# https://developers.cloudflare.com/rules/custom-error-responses/

resource "cloudflare_ruleset" "custom_error_rules" {
  zone_id     = var.cloudflare_zone_id
  name        = "Custom Error Rules"
  description = "Custom Error Rules"
  kind        = "zone"
  phase       = "http_custom_errors"

  rules {
    action     = "serve_error"
    expression = "(http.host eq \"outage.${var.cloudflare_zone}\")"
    enabled    = true
    action_parameters {
      content      = "<!DOCTYPE html><html><head><meta charset=\"utf-8\"><title>Outage</title></head><body><h1>Application temporarily unavailable</h1><p>Please try again later.</p></body></html>"
      content_type = "text/html"
      status_code  = 555
    }
  }
}
