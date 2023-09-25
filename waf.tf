# https://developers.cloudflare.com/waf/

resource "cloudflare_ruleset" "zone_level_managed_waf" {
  zone_id     = var.cloudflare_zone_id
  name        = "CF managed WAF"
  description = "CF managed WAF"
  kind        = "zone"
  phase       = "http_request_firewall_managed"

  #Leaked Credential Check
  rules {
    action = "execute"
    action_parameters {
      id = "c2e184081120413c86c3ab7e14069605"
    }
    expression  = "true"
    description = "Leaked Credentials"
    enabled     = true
  }

  #Cloudflare Managed Rules
  rules {
    action = "execute"
    action_parameters {
      id = "efb7b8c949ac4650a09736fc376e9aee"
      overrides {
        categories {
          category = "wordpress"
          action   = "block"
          enabled  = true
        }

        categories {
          category = "joomla"
          action   = "block"
          enabled  = true
        }
      }
    }

    expression  = "(http.host eq \"test.${var.zone}\")"
    description = "overrides to only enable wordpress rules to block"
    enabled     = false
  }

  #OWASP Managed Rules Skip Rule
  rules {
    action = "skip"
    action_parameters {
      rulesets = ["4814384a9e5d4991b9815dcfc25d2f1f"]
    }
    expression  = "(http.host eq \"login.${var.zone}\" and http.request.uri.path contains \"admin\")"
    description = "Skip OWASP for some traffic"
    logging {
      enabled = false
    }
    enabled = true
  }

  #OWASP Managed Rules
  rules {
    action = "execute"
    action_parameters {
      id = "4814384a9e5d4991b9815dcfc25d2f1f"
      overrides {

        categories {
          category = "paranoia-level-3"
          enabled  = false
        }

        categories {
          category = "paranoia-level-4"
          enabled  = false
        }

        rules {
          id              = "6179ae15870a4bb7b2d480d4843b323c"
          action          = "log"
          score_threshold = 60
        }
      }
    }
    expression  = "true"
    description = "OWASP Ruleset"
    enabled     = true
  }

}
