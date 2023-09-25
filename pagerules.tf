# https://developers.cloudflare.com/support/page-rules/understanding-and-configuring-cloudflare-page-rules-page-rules-tutorial/

resource "cloudflare_page_rule" "redirecthttpbin" {
  priority = 1
  status   = "active"
  target   = "http://httpbin.${var.cloudflare_zone}/*"
  zone_id  = var.cloudflare_zone_id
  actions {
    forwarding_url {
      url         = "https://httpbin.${var.cloudflare_zone}/$1"
      status_code = 302
    }
  }
}
