resource "cloudflare_api_shield" "zone_shield" {
  zone_id = var.cloudflare_zone_id
  auth_id_characteristics {
    name = "CF_Authorization"
    type = "cookie"
  }
  auth_id_characteristics {
    name = "authorization"
    type = "header"
  }
}

resource "cloudflare_api_shield_schema" "petstore_schema" {
  zone_id            = var.cloudflare_zone_id
  name               = "petstore"
  kind               = "openapi_v3" # optional
  validation_enabled = true         # optional, default false
  source             = file("./openapi.json")
}

resource "cloudflare_api_shield_schema_validation_settings" "petstore_schema" {
  zone_id                               = var.cloudflare_zone_id
  validation_default_mitigation_action  = "log"
  validation_override_mitigation_action = "disable_override"
}

resource "cloudflare_api_shield_operation" "httpbin_block" {
  zone_id  = var.cloudflare_zone_id
  method   = "HEAD"
  host     = "httpbin.${var.cloudflare_zone}"
  endpoint = "/anything/block"
}

resource "cloudflare_api_shield_operation_schema_validation_settings" "httpbin_block" {
  zone_id           = var.cloudflare_zone_id
  operation_id      = cloudflare_api_shield_operation.httpbin_block.id
  mitigation_action = "block"
}

resource "cloudflare_api_shield_operation" "httpbin_log" {
  zone_id  = var.cloudflare_zone_id
  method   = "HEAD"
  host     = "httpbin.${var.cloudflare_zone}"
  endpoint = "/anything/log"
}

resource "cloudflare_api_shield_operation_schema_validation_settings" "httpbin_log" {
  zone_id           = var.cloudflare_zone_id
  operation_id      = cloudflare_api_shield_operation.httpbin_log.id
  mitigation_action = "log"
}

data "cloudflare_rulesets" "sensitive_data_detection" {
  zone_id = var.cloudflare_zone_id
  filter {
    name = "Cloudflare Sensitive Data Detection"
  }
}

resource "cloudflare_ruleset" "sensitive_data_detection" {
  zone_id     = var.cloudflare_zone_id
  name        = "Cloudflare Sensitive Data Detection"
  description = "Cloudflare Sensitive Data Detection"
  kind        = "zone"
  phase       = "http_response_firewall_managed"

  #Leaked Credential Check
  rules {
    action = "execute"
    action_parameters {
      id = data.cloudflare_rulesets.sensitive_data_detection.rulesets[0].id
    }
    expression  = "true"
    description = "Cloudflare Sensitive Data Detection"
    enabled     = true
  }
}
