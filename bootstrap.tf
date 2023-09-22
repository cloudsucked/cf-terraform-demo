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
      version = "> 4.14.0"
    }
  }
  # backend "s3" {
  #   bucket = "tfstate"
  #   key    = "nz-demo/terraform.tfstate"

  #   region                      = "auto"
  #   skip_region_validation      = true
  #   skip_metadata_api_check     = true
  #   skip_credentials_validation = true
  #   force_path_style            = true

  # export AWS_ACCESS_KEY_ID="op://cloudflare/cflr-r2/S3-API/access-key-id"
  # export AWS_SECRET_ACCESS_KEY="op://cloudflare/cflr-r2/S3-API/secret-access-key"
  # export AWS_S3_ENDPOINT="https://{{op://cloudflare/cflr-account-id/credential}}.r2.cloudflarestorage.com"
  # }
}

provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_key
  # api_token = var.cloudflare_token
  # api_hostname = "au.api.cloudflare.com"
}
