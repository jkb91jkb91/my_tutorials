
output "vpc_id" {
  description = "something"
  value = module.vpc.vpc_id
}

output "example_output" {
  description = "A static example output"
  value       = module.vpc.example_output
}

output "public_subnet_ids" {
  description = "public_subnet_ids"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "private_subnet_ids"
  value       = module.vpc.private_subnet_ids
}

