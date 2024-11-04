resource "google_monitoring_dashboard" "MY-LB-DASHBOARD" {
 dashboard_json = <<EOF
{
  "displayName": "${var.dashboard_name}",
  "gridLayout": {
    "widgets": [
    {
      "title": "backend1 and backend2",
        "xyChart": {
    "dataSets": [
      {
        "timeSeriesQuery": {
          "timeSeriesFilter": {
            "filter": "metric.type=\"logging.googleapis.com/user/log2\" resource.type=\"l7_lb_rule\"",
            "aggregation": {
              "perSeriesAligner": "ALIGN_RATE",
              "crossSeriesReducer": "REDUCE_SUM",
              "groupByFields": []
            }
          }
        },
        "plotType": "LINE",
        "targetAxis": "Y1",
        "minAlignmentPeriod": "60s"
      },
      {
        "timeSeriesQuery": {
          "timeSeriesFilter": {
            "filter": "metric.type=\"logging.googleapis.com/user/my1\" resource.type=\"l7_lb_rule\"",
            "aggregation": {
              "perSeriesAligner": "ALIGN_RATE",
              "crossSeriesReducer": "REDUCE_SUM",
              "groupByFields": []
            }
          }
        },
        "plotType": "LINE",
        "targetAxis": "Y1",
        "minAlignmentPeriod": "60s"
      }
    ],
    "chartOptions": {
      "mode": "COLOR",
      "displayHorizontal": false
    },
    "thresholds": [],
    "yAxis": {
      "scale": "LINEAR"
    }
     }
    }
  ]
  }
}

EOF
}