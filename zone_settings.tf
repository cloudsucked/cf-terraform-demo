# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/zone_settings_override
resource "cloudflare_zone_settings_override" "my_zone_settings" {
  zone_id = var.cloudflare_zone_id
  settings {
    minify {
      css  = "on"
      html = "on"
      js   = "on"
    }
    security_header {
      enabled            = false
      include_subdomains = false
      max_age            = 0
      nosniff            = false
      preload            = false
    }
    always_online               = "off"
    always_use_https            = "on"
    automatic_https_rewrites    = "off"
    brotli                      = "on"
    browser_cache_ttl           = 14400
    browser_check               = "on"
    cache_level                 = "aggressive"
    challenge_ttl               = 300
    ciphers                     = ["ECDHE-ECDSA-AES128-GCM-SHA256", "ECDHE-ECDSA-CHACHA20-POLY1305", "ECDHE-ECDSA-AES256-GCM-SHA384", "ECDHE-RSA-AES128-SHA256", "ECDHE-RSA-CHACHA20-POLY1305", "ECDHE-RSA-AES256-GCM-SHA384"]
    cname_flattening            = "flatten_all"
    development_mode            = "off"
    early_hints                 = "off"
    email_obfuscation           = "on"
    hotlink_protection          = "off"
    http2                       = "on"
    http3                       = "on"
    ip_geolocation              = "on"
    ipv6                        = "on"
    max_upload                  = 100
    min_tls_version             = "1.1"
    mirage                      = "on"
    opportunistic_encryption    = "off"
    opportunistic_onion         = "on"
    origin_error_page_pass_thru = "off"
    polish                      = "lossless"
    prefetch_preload            = "on"
    privacy_pass                = "on"
    proxy_read_timeout          = "100"
    pseudo_ipv4                 = "off"
    response_buffering          = "off"
    rocket_loader               = "on"
    security_level              = "high"
    server_side_exclude         = "on"
    sort_query_string_for_cache = "on"
    ssl                         = "full"
    tls_1_3                     = "zrt"
    tls_client_auth             = "off"
    true_client_ip_header       = "off"
    webp                        = "on"
    websockets                  = "on"
    zero_rtt                    = "on"
  }
}

