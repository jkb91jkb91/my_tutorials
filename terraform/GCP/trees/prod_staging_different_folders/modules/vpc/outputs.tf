output "vpc_name" {
    value = google_compute_network.gke_network.name
}

output "subnetwork_id" {
    value = google_compute_subnetwork.gke_subnet.id
}

output "secondary_pods_ip_range_name" {
    value = google_compute_subnetwork.gke_subnet.secondary_ip_range[0].range_name
}

output "secondary_service_ip_range_name" {
    value = google_compute_subnetwork.gke_subnet.secondary_ip_range[1].range_name
}

