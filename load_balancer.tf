# https://developers.cloudflare.com/load-balancing/understand-basics/load-balancers/#load-balancers

resource "cloudflare_load_balancer_monitor" "example" {
  account_id     = var.cloudflare_account_id
  type           = "http"
  expected_body  = "alive"
  expected_codes = "2xx"
  method         = "GET"
  timeout        = 7
  path           = "/health"
  interval       = 60
  retries        = 5
  description    = "example http load balancer"
  header {
    header = "Host"
    values = ["lb.juiceshop.website"]
  }
  allow_insecure   = false
  follow_redirects = true
  probe_zone       = "juiceshop.website"
}

output "monitor_id" {
  value = cloudflare_load_balancer_monitor.example.id
}
