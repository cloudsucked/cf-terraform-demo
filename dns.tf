# https://developers.cloudflare.com/dns/manage-dns-records/
resource "cloudflare_record" "api" {
  zone_id = var.cloudflare_zone_id
  name    = "api"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
}

resource "cloudflare_record" "bandwidth" {
  zone_id = var.cloudflare_zone_id
  name    = "bandwidth"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
}

resource "cloudflare_record" "notification" {
  zone_id = var.cloudflare_zone_id
  name    = "notification"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
}

resource "cloudflare_record" "cache-worker" {
  zone_id = var.cloudflare_zone_id
  name    = "cache-worker"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
}

resource "cloudflare_record" "outage" {
  zone_id = var.cloudflare_zone_id
  name    = "outage"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
}

resource "cloudflare_record" "pacfile" {
  zone_id = var.cloudflare_zone_id
  name    = "pacfile"
  proxied = true
  ttl     = 1
  type    = "A"
  value   = "192.0.2.1"
}

resource "cloudflare_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "httpbin.org"
}

resource "cloudflare_record" "smh" {
  zone_id = var.cloudflare_zone_id
  name    = "smh"
  proxied = true
  ttl     = 1
  type    = "CNAME"
  value   = "smh.com.au"
}

resource "cloudflare_record" "httpbin" {
  zone_id = var.cloudflare_zone_id
  name    = "httpbin"
  proxied = true
  ttl     = 1
  type    = "A"
  // This uses data provided by the google_compute_instance resource to assign the empheral IP of the VPS to the DNS record
  value = google_compute_instance.gcp_origin.network_interface.0.access_config.0.nat_ip
}

resource "cloudflare_record" "juiceshop" {
  zone_id = var.cloudflare_zone_id
  name    = "juiceshop"
  proxied = true
  ttl     = 1
  type    = "A"
  // This uses data provided by the google_compute_instance resource to assign the empheral IP of the VPS to the DNS record
  value = google_compute_instance.gcp_origin.network_interface.0.access_config.0.nat_ip
}

resource "cloudflare_record" "petstore" {
  zone_id = var.cloudflare_zone_id
  name    = "petstore"
  proxied = true
  ttl     = 1
  type    = "A"
  // This uses data provided by the google_compute_instance resource to assign the empheral IP of the VPS to the DNS record
  value = google_compute_instance.gcp_origin.network_interface.0.access_config.0.nat_ip
}
