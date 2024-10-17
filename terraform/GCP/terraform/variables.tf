#Environment Variable
variable "environment" {
  description = "Env variable used as a prefix"
  type = string
  default = "dev"
}


#GCP Compute Engine Machine Type
variable "machine_type" {
    description = "Compute Engine Machine Type"
    type = string
    default = "e2-small"
}

variable "business_division" {
    description = "division"
    type = string
    default = "dev2"
}