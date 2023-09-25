# https://developers.cloudflare.com/workers/ 

resource "cloudflare_worker_script" "pacfile_worker" {
  account_id = var.cloudflare_account_id
  name       = "pacfile_worker"
  content    = file("pacfile.js")
}

resource "cloudflare_worker_route" "pacfile_worker_route" {
  zone_id     = var.cloudflare_zone_id
  pattern     = "pacfile.${var.zone}/proxy.pac"
  script_name = cloudflare_worker_script.pacfile_worker.name
}

# resource "cloudflare_workers_kv_namespace" "tf_worker_ns" {
#   account_id = var.cloudflare_account_id
#   title      = "tfworker"
# }

# resource "cloudflare_workers_kv" "tf_worker_kv" {
#   account_id   = var.cloudflare_account_id
#   namespace_id = cloudflare_workers_kv_namespace.tf_worker_ns.id
#   key          = "index.html"
#   value        = "<!DOCTYPE html> <html> <head> </head> <body> <h1>HELLO</h1> </body> </html>"
# }
