# EKS cluster security groups.

resource "aws_security_group" "cluster" {
  description = "Security group for EKS cluster control plane"
  name        = "${var.name_prefix}-cluster-security-group"
  vpc_id      = var.vpc_id
}

resource "aws_security_group" "worker" {
  description = "Security group for EKS worker nodes"
  name        = "${var.name_prefix}-node-security-group"
  vpc_id      = var.vpc_id
}

# Ingress/egress rules for the EKS cluster security group.

resource "aws_vpc_security_group_ingress_rule" "cluster_worker_443" {
  description = "Inbound traffic from worker nodes on port 443"

  security_group_id            = aws_security_group.cluster.id
  referenced_security_group_id = aws_security_group.worker.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
}

resource "aws_vpc_security_group_egress_rule" "cluster_worker_1025_65535" {
  description = "Outbound traffic to worker nodes on ports 1025-65535"

  security_group_id            = aws_security_group.cluster.id
  referenced_security_group_id = aws_security_group.worker.id

  ip_protocol = "tcp"
  from_port   = 1025
  to_port     = 65535
}

# Ingress rules for the EKS worker security group.

resource "aws_vpc_security_group_ingress_rule" "worker_worker_all" {
  description = "Inbound traffic from worker nodes on all ports"

  security_group_id            = aws_security_group.worker.id
  referenced_security_group_id = aws_security_group.worker.id

  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "worker_cluster_443" {
  description = "Inbound traffic from cluster control plane on port 443"

  security_group_id            = aws_security_group.worker.id
  referenced_security_group_id = aws_security_group.cluster.id

  ip_protocol = "tcp"
  from_port   = 443
  to_port     = 443
}

resource "aws_vpc_security_group_ingress_rule" "worker_cluster_1025_65535" {
  description = "Inbound traffic from cluster control plane on ports 1025-65535"

  security_group_id            = aws_security_group.worker.id
  referenced_security_group_id = aws_security_group.cluster.id

  ip_protocol = "tcp"
  from_port   = 1025
  to_port     = 65535
}
