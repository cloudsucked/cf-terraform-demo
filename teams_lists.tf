resource "cloudflare_teams_list" "example" {
  account_id  = var.cloudflare_account_id
  name        = "Corporate devices"
  type        = "SERIAL"
  description = "Serial numbers for all corporate devices."
  items       = ["8GE8721REF"]
}
