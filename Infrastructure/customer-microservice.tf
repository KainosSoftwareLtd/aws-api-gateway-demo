resource "aws_instance" "food_msvc" {
	ami = "${lookup(var.amis, var.region)}"
	instance_type = "t2.micro"
	key_name = "microservices"
	security_groups = ["allow_all"]

	tags {
		Name = "food_msvc_instance"
		Group = "api_gate_demo"
	}
}

resource "aws_eip" "ip_food_msvc" {
	instance = "${aws_instance.food_msvc.id}"
}