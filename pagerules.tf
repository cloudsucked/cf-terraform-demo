# https://developers.cloudflare.com/support/page-rules/understanding-and-configuring-cloudflare-page-rules-page-rules-tutorial/

resource "cloudflare_page_rule" "redirecthttpbin" {
  priority = 1
  status   = "active"
  target   = "http://httpbin.juiceshop.website/*"
  zone_id  = var.cloudflare_zone_id
  actions {
    forwarding_url {
      url         = "https://httpbin.juiceshop.website/$1"
      status_code = 302
    }
  }
}
