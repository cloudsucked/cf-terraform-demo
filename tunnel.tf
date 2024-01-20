resource "cloudflare_tunnel" "gcp_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "gcp_tunnel"
  secret     = var.tunnel_secret
}

resource "cloudflare_tunnel_config" "gcp_tunnel_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.gcp_tunnel.id

  config {
    ingress_rule {
      hostname = "httpbin.${var.cloudflare_zone}"
      service  = "http://172.18.0.11:80"
    }
    ingress_rule {
      hostname = "juiceshop.${var.cloudflare_zone}"
      service  = "http://172.18.0.12:3000"
    }
    ingress_rule {
      hostname = "petstore.${var.cloudflare_zone}"
      service  = "http://172.18.0.13:8080"
    }
    ingress_rule {
      service = "http_status:404"
    }
  }
}
