# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/healthcheck
resource "cloudflare_healthcheck" "http_health_check" {
  depends_on  = [cloudflare_record.petstore, cloudflare_load_balancer_monitor.example]
  zone_id     = var.cloudflare_zone_id
  name        = "http-health-check-${var.cloudflare_zone}"
  description = "example http health check"
  address     = "petstore.${var.cloudflare_zone}"
  suspended   = false
  check_regions = [
    "OC"
  ]
  type          = "HTTPS"
  port          = 443
  method        = "GET"
  path          = "/"
  expected_body = "Swagger"
  expected_codes = [
    "200",
  ]
  follow_redirects = false
  allow_insecure   = false
  header {
    header = "authorization"
    values = ["healthcheck was created via terraform"]
  }
  timeout               = 10
  retries               = 2
  interval              = 240
  consecutive_fails     = 2
  consecutive_successes = 2
}
