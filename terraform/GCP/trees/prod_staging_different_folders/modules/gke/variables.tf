variable "network_name" {
    description = "VPC name"
    type        = string
}

variable "subnetwork_id" {
    description = "subnetwork id"
    type        = string
}

variable "secondary_pods_ip_range_name" {
    description = "secondary_pods_ip_range_name"
    type        = string
}


variable "secondary_service_ip_range_name" {
    description = "secondary_service_ip_range_name"
    type        = string
}