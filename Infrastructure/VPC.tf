resource "aws_vpc" "vpc_main" {
    cidr_block = "10.0.0.0/16"

    tags {
        Name = "vpc_main"
	Group = "api_gate_demo"
    }
}
