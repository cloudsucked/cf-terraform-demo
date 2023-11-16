# # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/total_tls
# resource "cloudflare_total_tls" "total_tls_zone" {
#   zone_id               = var.cloudflare_zone_id
#   enabled               = true
#   certificate_authority = "lets_encrypt"
# }

# # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/hostname_tls_setting_ciphers
# resource "cloudflare_hostname_tls_setting_ciphers" "httpbin_ciphers" {
#   zone_id  = var.cloudflare_zone_id
#   hostname = cloudflare_record.httpbin.hostname
#   value = [
#     "ECDHE-ECDSA-AES128-GCM-SHA256"
#   ]
# }

# # https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs/resources/hostname_tls_setting
# resource "cloudflare_hostname_tls_setting" "httpbin_tls_settings" {
#   zone_id  = var.cloudflare_zone_id
#   hostname = cloudflare_record.httpbin.hostname
#   setting  = "min_tls_version"
#   value    = "1.2"
# }

# resource "cloudflare_hostname_tls_setting_ciphers" "www_ciphers" {
#   zone_id  = var.cloudflare_zone_id
#   hostname = cloudflare_record.www.hostname
#   value = [
#     "ECDHE-ECDSA-AES128-GCM-SHA256",
#     "ECDHE-ECDSA-AES256-GCM-SHA384"
#   ]
# }

# resource "cloudflare_hostname_tls_setting" "www_tls_settings" {
#   zone_id  = var.cloudflare_zone_id
#   hostname = cloudflare_record.www.hostname
#   setting  = "min_tls_version"
#   value    = "1.2"
# }
