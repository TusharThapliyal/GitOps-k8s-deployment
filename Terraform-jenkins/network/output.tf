output "Main_vpc_id" {
  value = aws_vpc.MAIN.id
}
output "Subnet_ids" {
  value = aws_subnet.PUBLIC_SUBNET.*.id
}
output "Subnet_id" {
  value = aws_subnet.PUBLIC_SUBNET[0].id
}
