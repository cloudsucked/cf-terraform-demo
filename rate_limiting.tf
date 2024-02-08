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
  rules {
    action      = "block"
    description = "POST counter bug"
    enabled     = true
    expression  = "(http.host matches \"^httpbin\\\\.\" and http.request.uri.path eq \"/post\" and not ip.src in $mycoprips and not ip.geoip.asnum in $bad_asn)"

    action_parameters {
      response {
        content      = "If you see this then you have been rate limited"
        content_type = "text/plain"
        status_code  = 429
      }
    }

    ratelimit {
      characteristics = [
        "cf.colo.id",
        "ip.src",
      ]
      counting_expression = "(http.request.method eq \"POST\")"
      mitigation_timeout  = 300
      period              = 300
      requests_per_period = 500
      requests_to_origin  = false
    }
  }

}
