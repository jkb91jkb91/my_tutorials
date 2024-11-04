# Global Address for Load Balancer
resource "google_compute_global_address" "default" {
  name = "global-ip-address"
}

# Target HTTP Proxy for Load Balancer
resource "google_compute_target_http_proxy" "http_proxy" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.id
}

# Global Forwarding Rule
resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "http-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy.id
  port_range = "80"
  ip_address = google_compute_global_address.default.address
}

# URL Map with Path Matcher
resource "google_compute_url_map" "default" {
  name            = "my-url-map"
  default_service = google_compute_backend_service.b_service_1.id

  host_rule {
    hosts        = ["*"]
    path_matcher = "my-path-matcher"
  }

  path_matcher {
    name            = "my-path-matcher"
    default_service = google_compute_backend_service.b_service_1.id

    path_rule {
      paths   = ["/"]
      service = google_compute_backend_service.b_service_1.id
    }

    path_rule {
      paths   = ["/api"]
      service = google_compute_backend_service.b_service_2.id
    }
  }
}

# Backend Services
resource "google_compute_backend_service" "b_service_1" {
  name                  = "example-backend-service1"
  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"
  backend {
    group = var.m_i_g_1
  }
  health_checks = [google_compute_health_check.default.self_link]
}

resource "google_compute_backend_service" "b_service_2" {
  name                  = "example-backend-service2"
  load_balancing_scheme = "EXTERNAL"
  protocol              = "HTTP"
  backend {
    group = var.m_i_g_2
  }
  health_checks = [google_compute_health_check.default.self_link]
}

# Health Check
resource "google_compute_health_check" "default" {
  name = "health-check-80"
  http_health_check {
    port = 80
    request_path = "/"
  }
  timeout_sec = 5
  check_interval_sec = 10
  healthy_threshold = 2
  unhealthy_threshold = 2
}
