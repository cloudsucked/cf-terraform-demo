resource "cloudflare_ruleset" "rate_limiting_example" {
  zone_id     = var.cloudflare_zone_id
  name        = "restrict API requests count"
  description = "apply HTTP rate limiting for a route"
  kind        = "zone"
  phase       = "http_ratelimit"

  rules {
    action = "block"
    ratelimit {
      characteristics = [
        "cf.colo.id",
        "ip.src"
      ]
      period              = 60
      requests_per_period = 10
      mitigation_timeout  = 60
    }

    expression  = "(http.request.uri.path matches \"^/anything/\")"
    description = "rate limit for API"
    enabled     = true
  }
}
