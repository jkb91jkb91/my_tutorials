output "instance_group_self_link" {
  description = "Self link of the instance group"
  value       = google_compute_instance_group.instance-group.self_link
}