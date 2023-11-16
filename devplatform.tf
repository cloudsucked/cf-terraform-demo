# https://developers.cloudflare.com/r2/buckets/
resource "cloudflare_r2_bucket" "logbucket" {
  account_id = var.cloudflare_account_id
  name       = "orangecloud-logs"
  #   location   = "apac"
}
