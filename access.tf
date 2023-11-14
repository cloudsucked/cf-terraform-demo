resource "cloudflare_access_application" "httpbin_application" {
  zone_id                   = var.cloudflare_zone_id
  name                      = "httpbin"
  domain                    = cloudflare_record.httpbin.hostname
  type                      = "self_hosted"
  session_duration          = "24h"
  auto_redirect_to_identity = false
}

resource "cloudflare_access_policy" "httpbin_policy" {
  application_id = cloudflare_access_application.httpbin_application.id
  zone_id        = var.cloudflare_zone_id
  name           = "Ninjas and Cloudflare"
  precedence     = "1"
  decision       = "allow"

  include {
    # group = ["uuid-of-group"]
    email = ["user@test.com"]
  }
}

