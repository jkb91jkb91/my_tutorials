output "ec2_id" {
  description = "ID of the EC2"
  value       = aws_instance.my_ec2.id
}