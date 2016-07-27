resource "aws_route_table" "main" {
  vpc_id = "${aws_vpc.vpc_main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.main.id}"
  }
}

resource "aws_route_table_association" "zone_a" {
  subnet_id      = "${aws_subnet.zone_a.id}"
  route_table_id = "${aws_route_table.main.id}"
}

resource "aws_route_table_association" "zone_b" {
  subnet_id      = "${aws_subnet.zone_b.id}"
  route_table_id = "${aws_route_table.main.id}"
}
