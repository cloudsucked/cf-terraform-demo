# resource "cloudflare_teams_list" "my_tf_serials" {
#   account_id  = var.cloudflare_account_id
#   name        = "Corporate devices"
#   type        = "SERIAL"
#   description = "Serial numbers for all corporate devices."
#   items       = ["8GE8721REF", "5RE8543EGG", "1YE2880LNP"]
# }

# output "serial_list" {
#   value = cloudflare_teams_list.my_tf_serials.id
# }

# resource "cloudflare_device_posture_rule" "posture_check" {
#   account_id  = var.cloudflare_account_id
#   name        = "Corporate devices posture rule"
#   type        = "os_version"
#   description = "Device posture rule for corporate devices."
#   schedule    = "24h"
#   expiration  = "24h"

#   match {
#     platform = "linux"
#   }

#   input {
#     id                 = cloudflare_teams_list.my_tf_serials.id
#     version            = "1.0.0"
#     operator           = "<"
#     os_distro_name     = "ubuntu"
#     os_distro_revision = "1.0.0"
#   }
# }
