# https://developers.cloudflare.com/waf/custom-rules/

resource "cloudflare_ruleset" "my_custom_rules" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_firewall_custom"
  zone_id = var.cloudflare_zone_id

  rules {
    action      = "log"
    description = "Log all requests to admin portal"
    enabled     = true
    expression  = "(http.host eq \"httpbin.juiceshop.website\" and lower(url_decode(http.request.uri.path)) matches \"^/admin.*\")"
  }

  rules {
    action      = "skip"
    description = "Allow pentesters to bypass security"
    enabled     = true
    expression  = "(http.host eq \"httpbin.juiceshop.website\" and ip.src in $allowlists)"
    action_parameters {
      phases = [
        "http_ratelimit",
        "http_request_firewall_managed",
        "http_request_sbfm",
      ]
      products = [
        "bic",
        "hot",
        "securityLevel",
        "uaBlock",
        "zoneLockdown",
      ]
      ruleset = "current"
    }
    logging {
      enabled = true
    }
  }

  rules {
    action      = "block"
    description = "Block truncated requests"
    enabled     = true
    expression  = "(http.request.headers.truncated or http.request.body.truncated)"
    action_parameters {
      response {
        content      = "No teapots allowed"
        content_type = "text/plain"
        status_code  = 418
      }
    }
  }

  rules {
    action      = "block"
    description = "Block non-allowlisted IP's from Admin"
    enabled     = true
    expression  = "(http.host eq \"httpbin.juiceshop.website\" and url_decode(http.request.uri.path) matches \"^/admin.*\" and not ip.src in $allowlists)"
  }

  rules {
    action      = "skip"
    description = "Bots: Whitelist Good Bots"
    enabled     = true
    expression  = "http.host eq \"httpbin.juiceshop.website\" and (cf.bot_management.verified_bot or ip.src in $allowlists)"
    action_parameters {
      phases = [
        "http_request_sbfm",
      ]
      ruleset = "current"
    }
    logging {
      enabled = true
    }
  }

  rules {
    action      = "block"
    description = "Bots: Block all Botscore < 30"
    enabled     = true
    expression  = "(http.host eq \"httpbin.juiceshop.website\" and cf.bot_management.score lt 30)"
  }

  rules {
    action      = "managed_challenge"
    description = "Geo Challenge"
    enabled     = true
    expression  = "(not ip.geoip.country in {\"AU\" \"NZ\"})"
  }
}
