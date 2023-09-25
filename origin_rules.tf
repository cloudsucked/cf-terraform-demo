# https://developers.cloudflare.com/rules/origin-rules/

resource "cloudflare_ruleset" "origin_rules" {
  zone_id     = var.cloudflare_zone_id
  name        = "Origin Rules"
  description = "Origin Rules"
  kind        = "zone"
  phase       = "http_request_origin"

  rules {
    action      = "route"
    description = "Change origin of API requests"
    enabled     = true
    expression  = "(http.request.uri.path matches \"^/nyt/\")"
    action_parameters {
      origin {
        host = "nytimes.${var.cloudflare_zone}"
        port = 443
      }
    }
  }
}


