# https://developers.cloudflare.com/rules/transform/
resource "cloudflare_ruleset" "transform_uri_rule_path" {
  zone_id     = var.cloudflare_zone_id
  name        = "http_request_transform"
  description = "change the URI path to a new static path"
  kind        = "zone"
  phase       = "http_request_transform"

  rules {
    action = "rewrite"
    action_parameters {
      uri {
        path {
          value = "/"
        }
        query {
          expression = "concat(\"/srp\", http.request.uri.path)"
        }
      }
    }
    expression  = "(http.request.uri.path matches \"^/assets/\")"
    description = "example URI path transform rule"
    enabled     = true
  }
  rules {
    action = "rewrite"
    action_parameters {
      uri {
        path {
          value = "/"
        }
        query {
          expression = "concat(\"/srp2\", http.request.uri.path)"
        }
      }
    }
    expression  = "(http.request.uri.path matches \"^/assets222/\")"
    description = "rule2"
    enabled     = true
  }
}

