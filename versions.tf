terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    statuscake = {
      source = "terraform-providers/statuscake"
    }
    auth0 = {
      source = "alexkappa/auth0"
    }
  }
  required_version = ">= 0.13"
}
