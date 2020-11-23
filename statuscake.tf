provider "statuscake" {
  username = var.statuscake_username
  apikey = var.statuscake_apikey
}

resource "statuscake_test" "pgrexam" {
  website_name = "Exam online status checker"
  website_url  = format("%s/wishes", google_cloud_run_service.default.status[0].url)
  test_type    = "HTTP"
  check_rate   = 300
  contact_group = ["Default"]
}