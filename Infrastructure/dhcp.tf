resource "aws_vpc_dhcp_options" "main" {
  domain_name = "microservices"
}

resource "aws_vpc_dhcp_options_association" "dns_resolver" {
  vpc_id          = "${aws_vpc.vpc_main.id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.main.id}"
}
