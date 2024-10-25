## VPC
resource "aws_vpc" "infra_vpc" {
  cidr_block = var.cidr_block
  
  tags = {
    Name = "infra-vpc"
  }
}

## SUBNET
resource "aws_subnet" "infra_public_subnet" {
  count = 2

  vpc_id = aws_vpc.infra_vpc.id
  map_public_ip_on_launch = true
  cidr_block = "${var.vpc_network_prefix}.${count.index}.0/24"
  availability_zone = count.index % 2 == 0 ? "ap-northeast-2a" : "ap-northeast-2c"

  tags = {
    Name = "public_subnet${count.index}"
  }
}

resource "aws_subnet" "infra_private_subnet" {
  count = 6

  vpc_id = aws_vpc.infra_vpc.id
  cidr_block = "${var.vpc_network_prefix}.${2 + count.index}.0/24"
  availability_zone = count.index % 2 == 0 ? "ap-northeast-2a" : "ap-northeast-2c"

  tags = {
    Name = "private_subnet${count.index}"
  }
}
## SUBNET END

## INTERNET GATEWAY
resource "aws_internet_gateway" "infra_internet_gateway" {
  vpc_id = aws_vpc.infra_vpc.id

  tags = {
    Name = "infra-internet-gateway"
  }
}

resource "aws_route_table" "infra_route_internet_gateway" {
  vpc_id = aws_vpc.infra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.infra_internet_gateway.id
  }

  tags = {
    Name = "infra-route-table-internet-gateway"
  }
}

resource "aws_route_table_association" "infra_route_association_public" {
  count = 2
  route_table_id = aws_route_table.infra_route_internet_gateway.id
  subnet_id = aws_subnet.infra_public_subnet[count.index].id
}
## INTERNET GATEWAY END

## NAT GATEWAY
resource "aws_eip" "infra_eip_ngw" {
  domain = "vpc"

  tags = {
    Name = "infra-eip-ngw"
  }
}

resource "aws_nat_gateway" "infra_nat_gateway" {
  allocation_id = aws_eip.infra_eip_ngw.id
  subnet_id = aws_subnet.infra_public_subnet[0].id

  tags = {
    Name = "infra-nat-gateway"
  }
}

resource "aws_route_table" "infra_route_nat_gateway" {
  vpc_id = aws_vpc.infra_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.infra_nat_gateway.id
  }

  tags = {
    Name = "infra-route-table-nat-gateway"
  }
}

resource "aws_route_table_association" "infra_route_association_private" {
  count = 6
  route_table_id = aws_route_table.infra_route_nat_gateway.id
  subnet_id = aws_subnet.infra_private_subnet[count.index].id
}
## NAT GATEWAY END
