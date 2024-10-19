output "id" {
    value = data.google_compute_image.my_image_data_source.id
}

output "vmimage_info" {
    value = {
        project = data.google_compute_image.my_image_data_source.id
        family  = data.google_compute_image.my_image_data_source.name
    }
}