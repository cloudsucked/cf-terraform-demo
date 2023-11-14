# https://developers.cloudflare.com/waf/
data "cloudflare_rulesets" "owasp_id" {
  zone_id = var.cloudflare_zone_id
  filter {
    name = ".*OWASP.*"
  }
}

data "cloudflare_rulesets" "cf_managed_id" {
  zone_id = var.cloudflare_zone_id
  filter {
    name = "Cloudflare Managed Ruleset"
  }
}

data "cloudflare_rulesets" "leaked_creds_id" {
  zone_id = var.cloudflare_zone_id
  filter {
    name = "Cloudflare Exposed Credentials Check Ruleset"
  }
}

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
      id = data.cloudflare_rulesets.leaked_creds_id.rulesets[0].id
    }
    expression  = "true"
    description = "Leaked Credentials"
    enabled     = true
  }

  #Cloudflare Managed Rules
  rules {
    action = "execute"
    action_parameters {
      id = data.cloudflare_rulesets.cf_managed_id.rulesets[0].id
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

    expression  = "(http.host eq \"test.${var.cloudflare_zone}\")"
    description = "overrides to only enable wordpress rules to block"
    enabled     = false
  }

  #OWASP Managed Rules Skip Rule
  rules {
    action = "skip"
    action_parameters {
      rulesets = [data.cloudflare_rulesets.owasp_id.rulesets[0].id]
    }
    expression  = "(http.host eq \"login.${var.cloudflare_zone}\" and http.request.uri.path contains \"admin\")"
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
      id = data.cloudflare_rulesets.owasp_id.rulesets[0].id
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
          score_threshold = 52
        }
      }
    }
    expression  = "true"
    description = "OWASP Ruleset"
    enabled     = true
  }

}
