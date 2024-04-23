resource "cloudflare_tunnel" "gcp_tunnel" {
  account_id = var.cloudflare_account_id
  name       = "gcp_tunnel"
  secret     = var.tunnel_secret
}

resource "cloudflare_tunnel_config" "gcp_tunnel_config" {
  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.gcp_tunnel.id

  config {
    warp_routing {
      enabled = true
    }
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

resource "cloudflare_tunnel_route" "tunnel_route" {
  for_each = {
    for key, value in var.cloudflare_tunnel_networks :
    key => value
  }

  account_id = var.cloudflare_account_id
  tunnel_id  = cloudflare_tunnel.gcp_tunnel.id
  network    = each.value.network
  comment    = each.value.comment
}

