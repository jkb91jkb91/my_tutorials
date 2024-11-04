# UNMANAGED INSTANCE GROUP 1
resource "google_compute_instance_group" "instance-group" {
  name        = var.name
  zone        = var.zone
  instances   = [var.instances_self_link]
}


# UNMANAGED INSTANCE GROUP 1
# resource "google_compute_instance_group" "instance-group-eur" {
# #   name        = "instance-group-eur"
# #   zone        = "europe-west1-b"
# #   instances   = [var.instances_self_link2]
# # }
