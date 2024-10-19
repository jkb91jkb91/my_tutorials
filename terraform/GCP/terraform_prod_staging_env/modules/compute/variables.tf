variable "instance_name" {
  description = "The name of the Compute Engine instance"
  type        = string
}

variable "machine_type" {
  description = "The type of machine to create"
  type        = string
}

variable "zone" {
  description = "The zone where the instance should be created"
  type        = string
}

variable "disk_image" {
  description = "The image to use for the boot disk"
  type        = string
}

variable "network" {
  description = "The network to attach the instance to"
  type        = string
}

variable "tags" {
  description = "List of tags for the instance"
  type        = list(string)
  default     = []
}
