# output "alb_dns_name" {
#   value = aws_lb.my_alb.dns_name
# }

# output "alb_zone_id" {
#   value = aws_lb.my_alb.zone_id
# }


output "alb_dns_name" {
  value = aws_lb.this.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.fargate_tg.arn
}

output "alb_sg_id" {
  value = aws_security_group.alb_sg.id
}