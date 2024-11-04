resource "google_monitoring_dashboard" "my_dashboard" {
 dashboard_json = <<EOF
{
  "displayName": "${var.dashboard_name}",
  "gridLayout": {
    "widgets": [
    {
      "title": "CPU Utilization",
      "xyChart": {
        "dataSets": [
          {
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\" AND resource.labels.instance_name=\"my-vm-instance\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "perSeriesAligner": "ALIGN_RATE"
                }
              }
            }
          }
        ]
      }
    },
    {
      "title": "Write to Disk",
      "xyChart": {
        "dataSets": [
          {
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"compute.googleapis.com/instance/disk/write_bytes_count\" AND resource.type=\"gce_instance\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "perSeriesAligner": "ALIGN_RATE"
                }
              }
            }
          }
        ]
      }
    },
    {
      "title": "Read from Disk",
      "xyChart": {
        "dataSets": [
          {
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"compute.googleapis.com/instance/disk/read_bytes_count\" AND resource.type=\"gce_instance\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "perSeriesAligner": "ALIGN_RATE"
                }
              }
            }
          }
        ]
      }
    },
    {
      "title": "RAM Used",
      "xyChart": {
        "dataSets": [
          {
            "timeSeriesQuery": {
              "timeSeriesFilter": {
                "filter": "metric.type=\"compute.googleapis.com/instance/memory/used\" AND resource.type=\"gce_instance\"",
                "aggregation": {
                  "alignmentPeriod": "60s",
                  "perSeriesAligner": "ALIGN_RATE"
                }
              }
            }
          }
        ]
      }
    }
  ]
  }
}

EOF
}