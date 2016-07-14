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

	provisioner "file" {
		source = "./Infrastructure/RunMicroservice.sh"
		destination = "~/RunMicroservice.sh"
		connection {
			user = "ec2-user"
		}
	}

	provisioner "remote-exec" {
		inline = [
		# Upgrade java
		"sudo yum install -y java-1.8.0",
		"sudo yum remove -y java-1.7.0-openjdk",

		# Export environment variables
		"echo 'export DWDEMO_USER=${var.DB_USERNAME}' >> ~/.bashrc",
		"echo 'export DWDEMO_PASSWORD=${var.DB_PASSWORD}' >> ~/.bashrc",
		"echo 'export DWDEMO_DB=jdbc:postgresql://${aws_db_instance.default.endpoint}/microservices' >> ~/.bashrc",
		"source ~/.bashrc",

		"chmod +x ~/RunMicroservice.sh",

		# Start Microservice if it's not running.
		"(crontab -l 2>/dev/null; echo '*/2 * * * * ~/RunMicroservice.sh ~/${var.FOOD_JAR} >> microservice.log 2>&1') | crontab -"
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