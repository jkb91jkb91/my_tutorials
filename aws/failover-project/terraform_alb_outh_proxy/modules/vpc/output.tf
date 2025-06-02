output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.main.id
}

output "public1_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public1.id
}

output "public2_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public2.id
}

output "public_ec2_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_ec2.id
}

output "private_subnet_id" {
  description = "ID of the private subnet"
  value       = aws_subnet.private.id
}