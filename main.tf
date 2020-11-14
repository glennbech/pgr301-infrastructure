resource "google_cloud_run_service" "default" {
  name     = "pgr-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/pgr301-exam-295320/app@sha256:47dd72d94febaacd2273f74abde70e88f51e0471fa4a3ac91c51a0d74055af51"
        env {
          name = "LOGZ_TOKEN"
          value = "var.logz_token"
        }
      }
    }
  }
}

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location    = google_cloud_run_service.default.location
  project     = google_cloud_run_service.default.project
  service     = google_cloud_run_service.default.name

  policy_data = data.google_iam_policy.noauth.policy_data
}