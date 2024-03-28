# https://developers.cloudflare.com/waf/
data "cloudflare_rulesets" "account_owasp_id" {
  account_id = var.cloudflare_account_id
  filter {
    name = "Cloudflare OWASP Core Ruleset"
  }
}

data "cloudflare_rulesets" "account_cf_managed_id" {
  account_id = var.cloudflare_account_id
  filter {
    name = "Cloudflare Managed Ruleset"
  }
}

data "cloudflare_rulesets" "account_cf_sensitive_data_id" {
  account_id = var.cloudflare_account_id
  filter {
    name = "Cloudflare Sensitive Data Detection"
  }
}

resource "cloudflare_ruleset" "account_level_managed_waf" {
  account_id  = var.cloudflare_account_id
  name        = "CF managed WAF"
  description = "CF managed WAF"
  kind        = "root"
  phase       = "http_request_firewall_managed"

  # OWASP Managed Rules Skip Rule
  rules {
    action = "skip"
    action_parameters {
      rulesets = [data.cloudflare_rulesets.account_owasp_id.rulesets[0].id]
    }
    expression  = "(cf.zone.plan eq \"ENT\")"
    description = "Skip OWASP for some traffic"
    logging {
      enabled = true
    }
    enabled = false
  }

  #Cloudflare Managed Rules
  rules {
    action = "execute"
    action_parameters {
      id = data.cloudflare_rulesets.account_cf_managed_id.rulesets[0].id
      overrides {
        categories {
          category = "joomla"
          action   = "block"
          enabled  = false
        }
        categories {
          category = "drupal"
          action   = "block"
          enabled  = false
        }
      }
    }

    expression  = "(cf.zone.plan eq \"ENT\")"
    description = "overrides to only enable wordpress rules to block"
    enabled     = true
  }

  #OWASP Managed Rules #1
  rules {
    action = "execute"
    action_parameters {
      id = data.cloudflare_rulesets.account_owasp_id.rulesets[0].id
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
          action          = "block"
          score_threshold = 52
        }
      }
    }
    expression  = "(cf.zone.plan eq \"ENT\")"
    description = "OWASP Ruleset"
    enabled     = true
  }

  #OWASP Managed Rules #2
  rules {
    action = "execute"
    action_parameters {
      id = data.cloudflare_rulesets.account_owasp_id.rulesets[0].id
      overrides {
        categories {
          category = "paranoia-level-1"
          enabled  = true
        }
        categories {
          category = "paranoia-level-2"
          enabled  = true
        }
        categories {
          category = "paranoia-level-3"
          enabled  = true
        }
        categories {
          category = "paranoia-level-4"
          enabled  = true
        }
      }
    }
    expression  = "((cf.zone.plan eq \"ENT\") and (http.host contains \"petstore.\"))"
    description = "OWASP Ruleset"
    enabled     = true
  }

}
