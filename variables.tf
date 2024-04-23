variable "cloudflare_tunnel_networks" {
  type = list(object({
    network = string
    comment = string
  }))
}
