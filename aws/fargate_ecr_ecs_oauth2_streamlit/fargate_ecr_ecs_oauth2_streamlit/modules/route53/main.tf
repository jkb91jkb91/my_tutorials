#resource "aws_route53_zone" "main" {

#  name = "projectdevops.eu" 
#}



# RECORD AUTOMATICALLY CREATED
#NS (Name Server) – 4 RECORDS SET IN GODADDY
#SOA (Start of Authority)


resource "aws_route53_zone" "main" {
  name = "projectdevops2.eu"
}


resource "aws_route53_record" "root_a" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "projectdevops2.eu"
  type    = "A"

alias {
    name                   = var.dns
    zone_id                = var.zone_id
    evaluate_target_health = true
  }
}