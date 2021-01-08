provider "google" {
  # Resource google_monitoring_dashboard is available since 3.23.0
  # https://github.com/terraform-providers/terraform-provider-google/releases/tag/3.23
  version = ">= 3.23.0"
}

variable "project_id" {
  description = "The ID of the project in which the dashboard will be created."
  type        = string
}

variable "dashboard_json_file" {
  description = "The JSON file of the dashboard."
  type        = string
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

output "project_id" {
  value = var.project_id
}

output "resource_id" {
  description = "The resource id for the dashboard"
  value       = google_monitoring_dashboard.dashboard.id
}

output "console_link" {
  description = "The destination console URL for the dashboard."
  value       = join("", ["https://console.cloud.google.com/monitoring/dashboards/custom/",
                          element(split("/", google_monitoring_dashboard.dashboard.id), 3),
                          "?project=",
                          var.project_id])
}
