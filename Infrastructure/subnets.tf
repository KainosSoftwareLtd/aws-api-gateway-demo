resource "aws_subnet" "zone_b" {
  availability_zone = "${var.region}b"
  vpc_id            = "${aws_vpc.vpc_main.id}"
  cidr_block        = "10.0.2.0/24"

  tags {
    Name  = "microservices_db_subnet"
    Group = "api_gate_demo"
  }
}

resource "aws_subnet" "zone_a" {
  availability_zone = "${var.region}a"
  vpc_id            = "${aws_vpc.vpc_main.id}"
  cidr_block        = "10.0.1.0/24"

  tags {
    Name  = "microservices_db_subnet"
    Group = "api_gate_demo"
  }
}

resource "aws_db_subnet_group" "microservices" {
  name        = "msvc_db_subnet"
  description = "A subnet group used by the microservices and their database"
  subnet_ids  = ["${aws_subnet.zone_a.id}", "${aws_subnet.zone_b.id}"]

  tags {
    Name  = "microservices_db_subnet_group"
    Group = "api_gate_demo"
  }
}
