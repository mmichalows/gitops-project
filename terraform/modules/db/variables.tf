variable "db_name" {
  type    = string
  default = "myappdb"
}

variable "db_user" {
  type    = string
  default = "admin"
}

variable "db_password" {
  type      = string
  sensitive = true # To sprawi, że Terraform ukryje hasło w logach
}

variable "vps_ip" {
  description = "Publiczny adres IP naszego serwera Lightsail"
  type        = string
}
