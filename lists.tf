# https://developers.cloudflare.com/waf/tools/lists/custom-lists/
resource "cloudflare_list" "allowlist" {
  account_id  = var.cloudflare_account_id
  name        = "allowlist"
  description = "Allowlisted IP's"
  kind        = "ip"

  item {
    value {
      ip = "1.2.3.4"
    }
    comment = "one"
  }

  item {
    value {
      ip = "1.2.3.5"
    }
    comment = "two"
  }
}
