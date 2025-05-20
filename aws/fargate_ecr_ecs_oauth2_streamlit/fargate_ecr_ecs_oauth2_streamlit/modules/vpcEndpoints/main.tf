# INTERFACE: ecr.api
resource "aws_vpc_endpoint" "ecr_api" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-1.ecr.api"
  vpc_endpoint_type = "Interface"
  
  subnet_ids        = [var.priv_subnet1_id, var.priv_subnet2_id]
  security_group_ids = [var.endpoint_sg_id]
  private_dns_enabled = true

     tags = {
    Name        = "API"
  }
}


# INTERFACE: ecr.dkr
resource "aws_vpc_endpoint" "ecr_dkr" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-1.ecr.dkr"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [var.priv_subnet1_id, var.priv_subnet2_id]
  security_group_ids = [var.endpoint_sg_id]
  private_dns_enabled = true

    tags = {
    Name        = "DKR"
  }

}

# # GATEWAY: s3
resource "aws_vpc_endpoint" "s3_gateway" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-1.s3"
  vpc_endpoint_type = "Gateway"
  route_table_ids   = var.s3_route_table_ids

   tags = {
    Name        = "S3"
  }
}

resource "aws_vpc_endpoint" "cloudwatch_logs" {
  vpc_id            = var.vpc_id
  service_name      = "com.amazonaws.us-east-1.logs"
  vpc_endpoint_type = "Interface"
  subnet_ids        = [var.priv_subnet1_id, var.priv_subnet2_id]
  security_group_ids = [var.endpoint_sg_id]


  private_dns_enabled = true

  tags = {
    Name = "cloudwatch-logs-endpoint"
  }
}
