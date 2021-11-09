resource "aws_security_group" "asg_instance_sg" {
  name        = "test-asg-instance-sg"
  description = "Test autoscaling group instance security group."
  vpc_id      = var.vpc_id

  tags = {
    Name        = "test-asg-instance-sg"
    Terraform   = "true"
    Environment = var.env
  }
}

resource "aws_security_group_rule" "sg-ingress-01" {
  type              = "ingress"
  description       = "Ingress ICMP traffic for ping."
  from_port         = -1
  to_port           = -1
  protocol          = "icmp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg_instance_sg.id
}

resource "aws_security_group_rule" "sg-ingress-02" {
  type              = "ingress"
  description       = "Ingress HTTP traffic."
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg_instance_sg.id
}

resource "aws_security_group_rule" "sg-ingress-03" {
  type              = "ingress"
  description       = "Ingress HTTPS traffic."
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg_instance_sg.id
}

resource "aws_security_group_rule" "sg-ingress-04" {
  type              = "ingress"
  description       = "Ingress SSH traffic."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg_instance_sg.id
}

resource "aws_security_group_rule" "sg-egress-01" {
  type              = "egress"
  description       = "Egress HTTP traffic."
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg_instance_sg.id
}

resource "aws_security_group_rule" "sg-egress-02" {
  type              = "egress"
  description       = "Egress HTTPS traffic."
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg_instance_sg.id
}

resource "aws_security_group_rule" "sg-egress-03" {
  type              = "egress"
  description       = "Egress SSH traffic."
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.asg_instance_sg.id
}
