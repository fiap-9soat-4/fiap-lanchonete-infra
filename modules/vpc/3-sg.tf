resource "aws_security_group" "eks" {
  name_prefix = "${local.name}-eks"
  description = "Allow MySQL inbound traffic"
  vpc_id      = module.vpc.vpc_id

  tags = merge(local.tags, {
    Name = "eks-sg"
  })
}

resource "aws_vpc_security_group_ingress_rule" "mysql_ingress" {
  security_group_id = aws_security_group.eks.id

  description = "TLS from VPC"
  cidr_ipv4   = module.vpc.vpc_cidr_block
  from_port   = 3306
  to_port     = 3306
  ip_protocol = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "mongodb_ingress" {
  security_group_id = aws_security_group.eks.id

  description = "TLS from VPC"
  cidr_ipv4   = module.vpc.vpc_cidr_block
  from_port   = 27017
  to_port     = 27017
  ip_protocol = "tcp"
}
