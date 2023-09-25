resource "cloudflare_healthcheck" "http_health_check" {
  zone_id     = var.cloudflare_zone_id
  name        = "http-health-check"
  description = "example http health check"
  address     = "pacfile.${var.cloudflare_zone}"
  suspended   = false
  check_regions = [
    "OC"
  ]
  type          = "HTTPS"
  port          = 443
  method        = "GET"
  path          = "/"
  expected_body = "alive"
  expected_codes = [
    "2xx",
    "301"
  ]
  follow_redirects = false
  allow_insecure   = false
  header {
    header = "x-test-header"
    values = ["pacfile.${var.cloudflare_zone}"]
  }
  timeout               = 10
  retries               = 2
  interval              = 300
  consecutive_fails     = 3
  consecutive_successes = 2
}
