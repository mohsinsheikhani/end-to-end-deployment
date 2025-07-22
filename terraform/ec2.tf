resource "aws_default_vpc" "default" {}

resource "aws_security_group" "allow_user_to_connect" {
  name        = "allow TLS"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = "mysecurity"
  }
}

# SSH
resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  description       = "SSH"
}

# HTTP
resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  description       = "HTTP"
}

# HTTPS
resource "aws_vpc_security_group_ingress_rule" "allow_https_ipv4" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  description       = "HTTPS"
}

# SMTP
resource "aws_vpc_security_group_ingress_rule" "allow_smtp_ipv4" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 25
  to_port           = 25
  ip_protocol       = "tcp"
  description       = "SMTP"
}

# SMTPS
resource "aws_vpc_security_group_ingress_rule" "allow_smtps_ipv4" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 465
  to_port           = 465
  ip_protocol       = "tcp"
  description       = "SMTPS"
}

# Redis (default port)
resource "aws_vpc_security_group_ingress_rule" "allow_redis_ipv4" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 6379
  to_port           = 6379
  ip_protocol       = "tcp"
  description       = "Redis"
}

# Custom TCP (3000–10000)
resource "aws_vpc_security_group_ingress_rule" "allow_custom_tcp_3000_10000" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  to_port           = 10000
  ip_protocol       = "tcp"
  description       = "Application Port"
}

# Custom TCP (30000–32767)
resource "aws_vpc_security_group_ingress_rule" "allow_custom_tcp_30000_32767" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 30000
  to_port           = 32767
  ip_protocol       = "tcp"
  description       = "Kubernetes Node Ports"
}

# Custom TCP (6443)
resource "aws_vpc_security_group_ingress_rule" "allow_custom_tcp_6443" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 6443
  to_port           = 6443
  ip_protocol       = "tcp"
  description       = "Kubernetes API"
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_user_to_connect.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

resource "aws_instance" "testinstance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_user_to_connect.id]

  tags = {
    Name = "Automate"
  }

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }
}
