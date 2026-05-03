variable "env_server_name" {
  type = string
}

variable "env_bundle_id" {
  type = string
}

variable "db_password" {
  description = "Hasło do bazy danych RDS"
  type        = string
  sensitive   = true
}
