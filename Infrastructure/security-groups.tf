resource "aws_security_group" "allow_microservices" {
  name        = "allow_microservices"
  description = "Allow in & out SSH, HTTP, HTTPS, DNS, PostgresSQL, Microservices traffic"
  vpc_id      = "${aws_vpc.vpc_main.id}"
}

resource "aws_security_group_rule" "ssh_out" {
  type              = "egress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "ssh_in" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "http_in" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "http_out" {
  type              = "egress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "https_out" {
  type              = "egress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "https_in" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "dns_udp_out" {
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "dns_udp_in" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "udp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "dns_out" {
  type              = "egress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "dns_in" {
  type              = "ingress"
  from_port         = 53
  to_port           = 53
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "postgres_in" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["${aws_vpc.vpc_main.cidr_block}"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}
resource "aws_security_group_rule" "postgres_out" {
  type              = "egress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  cidr_blocks       = ["${aws_vpc.vpc_main.cidr_block}"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "vpc_microservices_in" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8083
  protocol          = "tcp"
  cidr_blocks       = ["${aws_vpc.vpc_main.cidr_block}"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}

resource "aws_security_group_rule" "vpc_microservices_out" {
  type              = "egress"
  from_port         = 8080
  to_port           = 8083
  protocol          = "tcp"
  cidr_blocks       = ["${aws_vpc.vpc_main.cidr_block}"]
  security_group_id = "${aws_security_group.allow_microservices.id}"
}
