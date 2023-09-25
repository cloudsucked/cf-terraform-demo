# https://developers.cloudflare.com/logs/about/

data "cloudflare_api_token_permission_groups" "all" {}
resource "cloudflare_api_token" "logpush_r2_token" {
  name = "logpush_r2_token"
  policy {
    permission_groups = [
      data.cloudflare_api_token_permission_groups.all.account["Workers R2 Storage Write"],
    ]
    resources = {
      "com.cloudflare.api.account.*" = "*"
    }
  }
}

resource "cloudflare_logpush_job" "http_requests_r2" {
  enabled          = true
  zone_id          = var.cloudflare_zone_id
  name             = "Terraform Logpush Job"
  logpull_options  = "fields=ClientIP,ClientRequestHost,ClientRequestMethod,ClientRequestURI,EdgeEndTimestamp,EdgeResponseBytes,EdgeResponseStatus,EdgeStartTimestamp,RayID&timestamps=rfc3339"
  destination_conf = "r2://cloudsucked-test/http_requests?account-id=${var.cloudflare_account_id}&access-key-id=${cloudflare_api_token.logpush_r2_token.id}&secret-access-key=${sha256(cloudflare_api_token.logpush_r2_token.value)}"
  dataset          = "http_requests"
  filter = jsonencode( # prevents whitespace changes
    {
      where = {
        key      = "ClientCountry"
        operator = "eq"
        value    = "au"
      }
    }
  )
}
