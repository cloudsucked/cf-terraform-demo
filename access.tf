# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/access_application
resource "cloudflare_access_application" "httpbin_application" {
  account_id                = var.cloudflare_account_id
  name                      = "www"
  domain                    = cloudflare_record.www.hostname
  type                      = "self_hosted"
  session_duration          = "8h"
  auto_redirect_to_identity = false
  policies                  = [cloudflare_access_policy.httpbin_policy.id]
}

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/access_policy
resource "cloudflare_access_policy" "httpbin_policy" {
  # application_id = cloudflare_access_application.httpbin_application.id
  account_id = var.cloudflare_account_id
  name       = "Test Users"
  # precedence = "1"
  decision = "allow"

  include {
    # group = ["uuid-of-group"]
    email = [var.cloudflare_email]
  }
}

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/access_application
resource "cloudflare_access_application" "petstore_application" {
  account_id                = var.cloudflare_account_id
  name                      = "petstore"
  domain                    = cloudflare_record.petstore.hostname
  type                      = "self_hosted"
  session_duration          = "8h"
  auto_redirect_to_identity = false
  policies                  = [cloudflare_access_policy.petstore_policy.id] # Replaces DEPRECATED fields in access policy
}

# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/access_policy
resource "cloudflare_access_policy" "petstore_policy" {
  # application_id = cloudflare_access_application.petstore_application.id # DEPRECATED
  account_id = var.cloudflare_account_id
  name       = "Test Users"
  # precedence     = "1" # DEPRECATED
  decision = "allow"

  include {
    # group = ["uuid-of-group"]
    email = [var.cloudflare_email]
  }
}

