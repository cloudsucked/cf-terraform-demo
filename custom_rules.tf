# https://developers.cloudflare.com/waf/custom-rules/

resource "cloudflare_ruleset" "my_custom_rules" {
  kind    = "zone"
  name    = "default"
  phase   = "http_request_firewall_custom"
  zone_id = var.cloudflare_zone_id

  rules {
    action      = "managed_challenge"
    description = "Test Challenge order"
    enabled     = false
    expression  = "(http.host contains \"httpbin.juiceshop.website\")"
  }

  rules {
    action      = "block"
    description = "Block non default ports"
    enabled     = false
    expression  = "not (cf.edge.server_port in {80 443})"
  }

  rules {
    action      = "block"
    description = "Block wordpress break-in attempts"
    enabled     = false
    expression  = "(http.request.uri.path ~ \".*wp-login.php\" or http.request.uri.path ~ \".*xmlrpc.php\") and ip.src ne 192.0.2.1"
  }

  rules {
    action      = "skip"
    description = "Skip template"
    enabled     = true
    expression  = "(http.host eq \"skip.cloudsucked.com\")"
    action_parameters {
      ruleset = "current"
    }
    logging {
      enabled = true
    }
  }

}
