resource "aws_instance" "microservice" {
  ami                    = "${lookup(var.amis, var.region)}"
  instance_type          = "t2.micro"
  key_name               = "microservices"
  vpc_security_group_ids = ["${var.security_group_ids}"]
  subnet_id              = "${var.subnet_id}"

  tags {
    Name  = "${var.MSVC_NAME}_msvc_instance"
    Group = "api_gate_demo"
  }
}

resource "aws_eip" "MSVC_IP" {
  instance = "${aws_instance.microservice.id}"
  vpc      = true

  # Microservice .jar file
  provisioner "file" {
    source      = "${var.MSVC_PATH}/target/${var.JAR_FILE}"
    destination = "~/${var.JAR_FILE}"
    connection {
      user = "ec2-user"
      host = "${self.public_ip}"
    }
  }

  # Config used by the microservice
  provisioner "file" {
    source      = "${var.MSVC_PATH}/config.yml"
    destination = "~/config.yml"
    connection {
      user = "ec2-user"
      host = "${self.public_ip}"
    }
  }

  provisioner "file" {
    source      = "./Infrastructure/RunMicroservice.sh"
    destination = "~/RunMicroservice.sh"
    connection {
      user = "ec2-user"
      host = "${self.public_ip}"
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
      "echo 'export DWDEMO_DB=jdbc:postgresql://${var.db_endpoint}/microservices' >> ~/.bashrc",
      "source ~/.bashrc",

      "chmod +x ~/RunMicroservice.sh",

      # Start Microservice if it's not running.
      "(crontab -l 2>/dev/null; echo '*/2 * * * * ~/RunMicroservice.sh ~/${var.JAR_FILE} >> microservice.log 2>&1') | crontab -"]
    connection {
      user = "ec2-user"
      host = "${self.public_ip}"
    }
  }
}

output "ip_msvc" {
  value = "${aws_eip.MSVC_IP.public_ip}"
}
