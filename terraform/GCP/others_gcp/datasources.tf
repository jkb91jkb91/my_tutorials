data "google_compute_image" "my_image_data_source" {
  # Debian
  family  = "debian-11"
  project = "debian-cloud"

  # CentOs
  #family  = "centos-stream-9"
  #project = "centos-cloud"

  # RedHat
  #family  = "rhel-9"
  #project = "rhel-cloud"

  # Microsoft
  #family  = "debian-11"
  #project = "debian-cloud"

}
