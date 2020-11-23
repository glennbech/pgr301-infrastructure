provider "auth0" {
  debug = true
  client_id = var.auth0_provider_client_id
  client_secret = var.auth0_provider_client_secret
  domain = var.auth0_provider_domain
}

resource "auth0_resource_server" "auth0_cloud_run_api" {
  name        = "Cloud run API"
  identifier  = var.api_identifier
  signing_alg = "RS256"

  scopes {
    value       = "create:wishes"
    description = "Create wishes"
  }

  allow_offline_access                            = true
  token_lifetime                                  = 8600
  skip_consent_for_verifiable_first_party_clients = true
}

resource "auth0_client" "spa_auth" {
  name = "Spa auth"
  app_type = "spa"
  oidc_conformant = true
  is_first_party = true
  token_endpoint_auth_method = "none"
  callbacks = ["http://localhost:8081", google_cloud_run_service.default.status[0].url]
  grant_types = [ "implicit", "authorization_code", "refresh_token" ]
  allowed_origins = ["http://localhost:8081", google_cloud_run_service.default.status[0].url]
  web_origins = ["http://localhost:8081", google_cloud_run_service.default.status[0].url]
  allowed_logout_urls = [ "http://localhost:8081", google_cloud_run_service.default.status[0].url ]
  jwt_configuration {
    lifetime_in_seconds = 300
    secret_encoded = true
    alg = "RS256"
  }
}
resource "auth0_connection" "terraform-spa-user-db" {
  name     = "spa-user-db"
  strategy = "auth0"
  options {
    password_policy        = "good"
    brute_force_protection = true
  }
  enabled_clients = [auth0_client.spa_auth.id, var.auth0_provider_client_id]
}