# https://developers.cloudflare.com/dns/manage-dns-records/

resource "cloudflare_record" "api" {
  name    = "api"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "bandwidth" {
  name    = "bandwidth"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "notification" {
  name    = "notification"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "cache-worker" {
  name    = "cache-worker"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "outage" {
  name    = "outage"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "pacfile" {
  name    = "pacfile"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "httpbin" {
  name    = "httpbin"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "httpbin.org"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "smh" {
  name    = "smh"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "smh.com.au"
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "www" {
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "juice-shop.herokuapp.com"
  zone_id = var.cloudflare_zone_id
}
