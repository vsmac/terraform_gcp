
  resource "google_monitoring_notification_channel" "basic" {
  display_name = "Test Notification Channel"
  type         = "email"
  labels = {
    email_address = "xx@gmail.com"
  }
}
resource "google_monitoring_alert_policy" "memory_alert" {
  combiner              = "OR"
  display_name          = "memory alert"
  notification_channels = [google_monitoring_notification_channel.basic.id]
  conditions {
    display_name = "memory usage"
    condition_threshold {
      filter          = "resource.type=\"gce_instance\" AND metric.type=\"agent.googleapis.com/memory/percent_used\" "
      duration        = "60s"
      comparison      = "COMPARISON_GT"
      threshold_value = "0.9"
      aggregations {
        alignment_period   = "60s"
      }
    }
  }
}




resource "google_monitoring_alert_policy" "cpu_alert_policy" {
  display_name = "CPU Alert Policy"
  combiner     = "OR"
  notification_channels = [google_monitoring_notification_channel.basic.id]
  conditions {
    display_name = "CPU Alert condition"
    condition_threshold {
      filter     = "metric.type=\"compute.googleapis.com/instance/cpu/utilization\" AND resource.type=\"gce_instance\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = "0.9"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
}

resource "google_monitoring_alert_policy" "disk_alert_policy" {
  display_name = "CPU Alert Policy"
  combiner     = "OR"
  notification_channels = [google_monitoring_notification_channel.basic.id]
  conditions {
    display_name = "disk Alert condition"
    condition_threshold {
      filter     = "metric.type=\"agent.googleapis.com/disk/percent_used\" AND resource.type=\"gce_instance\""
      duration   = "60s"
      comparison = "COMPARISON_GT"
      threshold_value = "0.9"
      aggregations {
        alignment_period   = "60s"
        per_series_aligner = "ALIGN_MAX"
      }
    }
  }
}




