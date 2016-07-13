resource "aws_db_instance" "default" {
	allocated_storage    = 5
	storage_type		 = "gp2"
	engine               = "postgres"
	engine_version       = "9.5.2"
	instance_class       = "db.t2.micro"
	name                 = "microservices"
	username             = "msvc_admin"
	password             = "12341234"
	vpc_security_group_ids = ["${aws_security_group.allow_all.id}"]

	tags {
		Name = "msvc_database"
		Group = "api_gate_demo"
	}
}
