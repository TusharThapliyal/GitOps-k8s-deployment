variable "Region" {
  type        = string
  description = "default region"
}
variable "Vpc_cidr" {
  type = string
}
variable "Public_subnet_cidr" {
  type = list(string)
}
variable "Availability_zone" {
  type = list(string)
}
variable "Instance" {
  type = string
}
variable "Public_ip_boolean" {
  type = bool
}
variable "Tag_name" {
  type = string
}
variable "Name" {
  type = string
}
variable "Port" {}
variable "Protocol" {
  type = string
}
