resource "cloudflare_teams_rule" "example" {
  account_id  = var.cloudflare_account_id
  name        = "office"
  description = "desc"
  precedence  = 1
  action      = "block"
  filters     = ["http"]
  traffic     = "http.request.uri == \"https://www.example.com/malicious\""
  rule_settings {
    block_page_enabled = true
    block_page_reason  = "access not permitted"
  }
}
