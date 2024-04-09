variable "Vpc_cidr" {
    type=string
}
variable "Public_subnet_cidr" {
 type=list(string)
}
variable "Availability_zone" {
  type=list(string)
}