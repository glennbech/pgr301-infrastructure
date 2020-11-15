provider "statuscake" {
  username = var.statuscake_username
}

resource "statuscake_test" "pgrexam" {
  website_name = "Exam is online"
  website_url  = google_cloud_run_service.default.status[0].url
  test_type    = "HTTP"
  check_rate   = 300
  contact_group = ["Default"]
}