#vpc
resource "aws_vpc" "MAIN" {
  cidr_block = var.Vpc_cidr
  tags = {
    Name = "my_vpc"
  }
}
#public subnet
resource "aws_subnet" "PUBLIC_SUBNET" {
  vpc_id            = aws_vpc.MAIN.id
  cidr_block        = element(var.Public_subnet_cidr, count.index)
  count             = length(var.Public_subnet_cidr)
  availability_zone = element(var.Availability_zone, count.index)
  tags = {
    Name = "my_public_subnet_${count.index + 1}"
  }
}
#igw
resource "aws_internet_gateway" "IGW" {
  vpc_id = aws_vpc.MAIN.id
  tags = {
    Name = "my_igw"
  }
}
#route table
resource "aws_route_table" "ROUTE_TABLE_WITH_IGW" {
  vpc_id = aws_vpc.MAIN.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IGW.id
  }
  tags = {
    Name = "route_table_with_igw"
  }
}
#route table association
resource "aws_route_table_association" "PUBLIC_ROUTE_ASSOC" {
  count          = length(var.Public_subnet_cidr)
  route_table_id = aws_route_table.ROUTE_TABLE_WITH_IGW.id
  subnet_id      = element(aws_subnet.PUBLIC_SUBNET[*].id, count.index)
}
