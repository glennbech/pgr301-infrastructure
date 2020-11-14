provider "google" {
  credentials = file("gkey.json")
  project     = "pgr301-exam-295320"
  region      = "us-central1"
  zone        = "us-central1-c"
}