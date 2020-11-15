terraform {
  backend "gcs" {
    bucket  = "tf-state-exam"
    prefix  = "terraform/state"
  }
}