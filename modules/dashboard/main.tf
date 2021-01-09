provider "google" {
  # Resource google_monitoring_dashboard is available since 3.23.0
  # https://github.com/terraform-providers/terraform-provider-google/releases/tag/3.23
  version = ">= 3.23.0"
}



resource "google_project_service" "enable_destination_api" {
  project            = var.project_id
  service            = "monitoring.googleapis.com"
  disable_on_destroy = false
}

resource "google_monitoring_dashboard" "dashboard" {
  dashboard_json = file(var.dashboard_json_file)
  project        = var.project_id
}

