# 1. Tworzymy Security Group (nasz firewall)
resource "aws_security_group" "rds_sg" {
  name        = "allow_mysql_from_vps"
  description = "Zezwalaj na ruch MySQL z serwera Lightsail"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["${var.vps_ip}/32"] # Tylko ten jeden konkretny IP może wejść!
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# 2. Tworzymy instancję bazy RDS
resource "aws_db_instance" "mysql_db" {
  allocated_storage      = 20               # Minimalna ilość (20GB)
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t4g.micro"   # Najtańsza opcja poza Free Tier
  db_name                = var.db_name
  username               = var.db_user
  password               = var.db_password
  parameter_group_name   = "default.mysql8.0"
  skip_final_snapshot    = true             # Bardzo ważne przy testach, inaczej usuwanie trwa wiecznie
  publicly_accessible    = true             # Musi być true, aby Lightsail mógł się połączyć przez internet
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
}

# 3. Wyciągamy adres bazy (endpoint), żebyśmy wiedzieli gdzie się łączyć
output "db_endpoint" {
  value = aws_db_instance.mysql_db.endpoint
}
