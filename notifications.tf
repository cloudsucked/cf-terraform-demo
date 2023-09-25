# resource "cloudflare_notification_policy_webhooks" "webhook" {
#   account_id = var.cloudflare_account_id
#   name       = "Juiceshop Webhook TF Test"
#   url        = "https://notification.${var.cloudflare_zone}"
#   secret     = "my-secret"
# }
