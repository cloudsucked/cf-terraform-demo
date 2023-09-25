# https://developers.cloudflare.com/cache/how-to/cache-rules/

resource "cloudflare_ruleset" "cache_settings" {
  zone_id     = var.cloudflare_zone_id
  name        = "Cache Rules"
  description = "Cache Rules"
  kind        = "zone"
  phase       = "http_request_cache_settings"

  rules {
    action      = "set_cache_settings"
    expression  = "(http.host eq httpbin.${var.cloudflare_zone})"
    description = "set cache settings rule"
    enabled     = true
    action_parameters {
      edge_ttl {
        mode = "respect_origin"
      }
    }
  }
}
