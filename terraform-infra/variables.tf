variable "subscription_id" {
  type = string
}
variable "db_username" {
  type = string
}
variable "db_password" {
  type      = string
  sensitive = true
}
variable "admin_ips" {
  description = "Comma separated CIDRs"
  type        = string
}
