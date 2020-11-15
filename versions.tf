terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
    }
    statuscake = {
      source = "terraform-providers/statuscake"
    }
  }
  required_version = ">= 0.13"
}
