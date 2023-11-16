# https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs
variable "cloudflare_email" {}
variable "cloudflare_key" {}
variable "cloudflare_token" {}
variable "cloudflare_zone" {}
variable "cloudflare_zone_id" {}
variable "cloudflare_account_id" {}

terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 4.19.0"
    }
  }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_key
  # api_token = var.cloudflare_token
  # api_hostname = "au.api.cloudflare.com"
}
