resource "aws_instance" "food_msvc" {
	ami = "${lookup(var.amis, var.region)}"
	instance_type = "t2.micro"
	key_name = "microservices"
	vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

	provisioner "file" {
		source = "${var.FOODSVC_PATH}/target/${var.FOOD_JAR}"
		destination = "~/${var.FOOD_JAR}"
		connection {
			user = "ec2-user"
		}
	}

	provisioner "file" {
		source = "${var.FOODSVC_PATH}/config.yml"
		destination = "~/config.yml"
		connection {
			user = "ec2-user"
		}
	}

	provisioner "remote-exec" {
		inline = [
		"sudo yum install -y java-1.8.0",
		"sudo yum remove -y java-1.7.0-openjdk",
		"echo 'export DWDEMO_USER=${var.DB_USERNAME}' >> ~/.bashrc",
		"echo 'export DWDEMO_PASSWORD=${var.DB_PASSWORD}' >> ~/.bashrc",
		"echo 'export DWDEMO_DB=jdbc:postgresql://${aws_db_instance.default.endpoint}/microservices' >> ~/.bashrc",
		"source ~/.bashrc",
		# TODO: use an agent to run this .jar  
		"java -jar ~/food-root-1.0-SNAPSHOT.jar server ~/config.yml"
		]
		connection {
			user = "ec2-user"
		}
	}

	tags {
		Name = "food_msvc_instance"
		Group = "api_gate_demo"
	}
}

resource "aws_eip" "ip_food_msvc" {
	instance = "${aws_instance.food_msvc.id}"
}