variable "instance_name1" {
  description = "Name of the VM instance"
  type        = string
}

variable "instance_name2" {
  description = "Name of the VM instance"
  type        = string
}

variable "machine_type" {
  description = "Type of the machine"
  type        = string
}

variable "zone1" {
  description = "Zone where the VM will be deployed"
  type        = string
}

variable "zone2" {
  description = "Zone where the VM will be deployed"
  type        = string
}

variable "disk_image" {
  description = "The disk image to use for the instance"
  type        = string
}

variable "network" {
  description = "Network to which the instance will be attached"
  type        = string
}

variable "tags" {
  description = "Tags to associate with the instance"
  type        = list(string)
}

variable "assign_public_ip" {
  type = bool
}

variable "d_name" {
  type = string
}

variable "d_lb_name" {
  type = string
}

variable "group_name_1" {
  type = string
}

variable "group_zone_1" {
  type = string
}

variable "group_name_2" {
  type = string
}

variable "group_zone_2" {
  type = string
}