resource "aws_vpc" "vpc_main" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true

    tags {
        Name = "vpc_main"
        Group = "api_gate_demo"
    }
}

resource "aws_internet_gateway" "main" {
    vpc_id = "${aws_vpc.vpc_main.id}"

    tags {
        Name = "microservices_db_subnet"
        Group = "api_gate_demo"
    }
}
