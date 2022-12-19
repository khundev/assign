resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}
resource "aws_subnet" "private" {
  vpc_id     = aws_default_vpc.default.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "private subnet"
  }
}

resource "aws_default_subnet" "default_1a" {
  availability_zone = "ap-southeast-1a"

  tags = {
    Name = "Default"
  }
}

resource "aws_default_subnet" "default_1b" {
  availability_zone = "ap-southeast-1b"

  tags = {
    Name = "Default"
  }
}

resource "aws_default_subnet" "default_1c" {
  availability_zone = "ap-southeast-1c"

  tags = {
    Name = "Default"
  }
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
  tags = {
    Name = "Default"
  }
}

data "aws_subnet" "default" {
  for_each = toset(data.aws_subnets.default.ids)
  id       = each.value
}

resource "aws_eip" "nat-eip" {
}

resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_default_subnet.default_1a.id

  tags = {
    Name = "gw NAT"
  }
}

resource "aws_route_table" "nat_gateway" {
  vpc_id = aws_default_vpc.default.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }
}

resource "aws_route_table_association" "nat_gateway" {
  subnet_id = aws_subnet.private.id
  route_table_id = aws_route_table.nat_gateway.id
}