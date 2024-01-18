# https://developers.cloudflare.com/rules/origin-rules/
resource "cloudflare_ruleset" "origin_rules" {
  zone_id     = var.cloudflare_zone_id
  name        = "Origin Rules"
  description = "Origin Rules"
  kind        = "zone"
  phase       = "http_request_origin"

  rules {
    action      = "route"
    description = "Port override for juiceshop.${var.cloudflare_zone}"
    enabled     = true
    expression  = "(http.host eq \"juiceshop.${var.cloudflare_zone}\")"
    action_parameters {
      origin {
        port = 81
      }
    }
  }
  rules {
    action      = "route"
    description = "Port override for petstore.${var.cloudflare_zone}"
    enabled     = true
    expression  = "(http.host eq \"petstore.${var.cloudflare_zone}\")"
    action_parameters {
      origin {
        port = 82
      }
    }
  }
}
