provider "aws" {
	region = "${var.region}"
}

resource "aws_instance" "msvc_1" {
	ami = "${lookup(var.amis, var.region)}"
	instance_type = "t2.micro"
	key_name = "microservices"
	security_groups = ["allow_all"]

	tags {
		Name = "msvc_1_instance"
		Group = "api_gate_demo"
	}
}

resource "aws_instance" "msvc_2" {
	ami = "${lookup(var.amis, var.region)}"
	instance_type = "t2.micro"
	key_name = "microservices"
	security_groups = ["allow_all"]

	tags {
		Name = "msvc_2_instance"
		Group = "api_gate_demo"
	}
}

resource "aws_eip" "ip_msvc_1" {
	instance = "${aws_instance.msvc_1.id}"
}

resource "aws_eip" "ip_msvc_2" {
	instance = "${aws_instance.msvc_2.id}"
}

