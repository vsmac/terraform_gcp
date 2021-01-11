
  resource "google_monitoring_notification_channel" "basic" {
  display_name = "Test Notification Channel"
  type         = "email"
  labels = {
    email_address = "xx@gmail.com"
  }
}
resource "google_monitoring_alert_policy" "backend_restart_count_alert" {
  combiner              = "OR"
  display_name          = "Backend pod keeps restarting"
  notification_channels = [google_monitoring_notification_channel.basic.id]
  conditions {
    display_name = "Restart count"
    condition_threshold {
      filter          = "resource.type=\"gce_instance\" AND metric.type=\"agent.googleapis.com/memory/percent_used\" "
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = 50
      aggregations {
        alignment_period   = "60s"
      }
    }
  }
}
