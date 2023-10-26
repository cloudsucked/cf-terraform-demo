resource "cloudflare_total_tls" "total_tls_zone" {
  zone_id               = var.cloudflare_zone_id
  enabled               = true
  certificate_authority = "lets_encrypt"
}

resource "cloudflare_hostname_tls_setting_ciphers" "httpbin_ciphers" {
  zone_id  = var.cloudflare_zone_id
  hostname = cloudflare_record.httpbin.hostname
  value    = ["ECDHE-RSA-AES128-GCM-SHA256"]
}

resource "cloudflare_hostname_tls_setting" "httpbin_tls_settings" {
  zone_id  = var.cloudflare_zone_id
  hostname = cloudflare_record.httpbin.hostname
  setting  = "min_tls_version"
  value    = "1.2"
}
