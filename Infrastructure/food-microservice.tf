resource "aws_instance" "customer_msvc" {
	ami = "${lookup(var.amis, var.region)}"
	instance_type = "t2.micro"
	key_name = "microservices"
	security_groups = ["allow_all"]

	tags {
		Name = "customer_msvc_instance"
		Group = "api_gate_demo"
	}
}

resource "aws_eip" "ip_customer_msvc" {
	instance = "${aws_instance.customer_msvc.id}"
}