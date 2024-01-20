resource "cloudflare_api_shield" "zone_shield" {
  zone_id = var.cloudflare_zone_id
  #   auth_id_characteristics {
  #     name = "my-example-header"
  #     type = "header"
  #   }
}

resource "cloudflare_api_shield_schema" "petstore_schema" {
  zone_id            = var.cloudflare_zone_id
  name               = "petstore"
  kind               = "openapi_v3" # optional
  validation_enabled = true         # optional, default false
  source             = file("./openapi.json")
}
