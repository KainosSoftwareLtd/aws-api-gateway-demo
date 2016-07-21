resource "aws_db_instance" "microservices" {
  allocated_storage      = 5
  storage_type           = "gp2"
  engine                 = "postgres"
  engine_version         = "9.5.2"
  instance_class         = "db.t2.micro"
  name                   = "microservices"
  username               = "${var.DB_USERNAME}"
  password               = "${var.DB_PASSWORD}"
  vpc_security_group_ids = ["${var.security_group_id}"]
  db_subnet_group_name   = "${var.db_subnet_group_name}"
  multi_az               = false

  tags {
    Name  = "msvc_database"
    Group = "api_gate_demo"
  }
}

output "microservices_db_endpoint" {
  value = "${aws_db_instance.microservices.endpoint}"
}
