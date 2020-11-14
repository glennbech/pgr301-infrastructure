resource "google_cloud_run_service" "default" {
  name     = "pgr-service"
  location = "us-central1"

  template {
    spec {
      containers {
        image = "gcr.io/pgr301-exam-295320/app@sha256:5d40433b1f8963b27a7ab94ddaf62000aa98fd0f8b83835839a87561d8500e18"
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