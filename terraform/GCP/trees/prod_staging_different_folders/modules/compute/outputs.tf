output "instance_public_ipip" {
  description = "Public IP address of the instance"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "vm1_self_link" {
  description = "Self link of VM1"
  value       = google_compute_instance.vm_instance.self_link
}