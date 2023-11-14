# https://developers.cloudflare.com/rules/configuration-rules/
resource "cloudflare_ruleset" "config_rules" {
  zone_id     = var.cloudflare_zone_id
  name        = "Configuration Rules"
  description = "Configuration Rules"
  kind        = "zone"
  phase       = "http_config_settings"

  rules {
    action      = "set_config"
    expression  = "(http.host eq \"httpbin.${var.cloudflare_zone}\")"
    description = "Configuration Rules"
    enabled     = true
    action_parameters {
      automatic_https_rewrites = false
      security_level           = "essentially_off"
      ssl                      = "full"
    }
  }
}
