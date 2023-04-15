resource "aws_vpc" "Vpc" {
  cidr_block           = var.CidrBlock
  enable_dns_support   = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"

  tags = {
    Name = "${var.App}-${var.Environment}-Vpc"
  }
}

resource "aws_internet_gateway" "InternetGateway" {
  vpc_id = aws_vpc.Vpc.id

  tags = {
    Name = "${var.App}-${var.Environment}-InternetGateway"
  }
}

resource "aws_subnet" "PublicSubnet1" {
  cidr_block              = var.PublicSubnet1_Block
  vpc_id                  = aws_vpc.Vpc.id
  availability_zone       = var.AzPublicSubnet1
  map_public_ip_on_launch = true

  tags = {
    Name       = "${var.App}-${var.Environment}-PublicSubnet1"
    Visibility = "Public"
  }
}

resource "aws_subnet" "PublicSubnet2" {
  cidr_block              = var.PublicSubnet2_Block
  vpc_id                  = aws_vpc.Vpc.id
  availability_zone       = var.AzPublicSubnet2
  map_public_ip_on_launch = true

  tags = {
    Name       = "${var.App}-${var.Environment}-PublicSubnet2"
    Visibility = "Public"
  }
}

resource "aws_subnet" "PublicSubnet3" {
  count                   = var.EnbaleThreeAzs ? 1 : 0
  cidr_block              = var.PublicSubnet3_Block
  vpc_id                  = aws_vpc.Vpc.id
  availability_zone       = var.AzPublicSubnet3
  map_public_ip_on_launch = true

  tags = {
    Name       = "${var.App}-${var.Environment}-PublicSubnet3"
    Visibility = "Public"
  }
}

resource "aws_subnet" "PrivateSubnet1" {
  cidr_block        = var.PrivateSubnet1_Block
  vpc_id            = aws_vpc.Vpc.id
  availability_zone = var.AzPrivateSubnet1

  tags = {
    Name       = "${var.App}-${var.Environment}-PrivateSubnet1"
    Visibility = "Private"
  }
}

resource "aws_subnet" "PrivateSubnet2" {

  cidr_block        = var.PrivateSubnet2_Block
  vpc_id            = aws_vpc.Vpc.id
  availability_zone = var.AzPrivateSubnet2

  tags = {
    Name       = "${var.App}-${var.Environment}-PrivateSubnet2"
    Visibility = "Private"
  }
}

resource "aws_subnet" "PrivateSubnet3" {
  count             = var.EnbaleThreeAzs ? 1 : 0
  cidr_block        = var.PrivateSubnet3_Block
  vpc_id            = aws_vpc.Vpc.id
  availability_zone = var.AzPrivateSubnet3

  tags = {
    Name       = "${var.App}-${var.Environment}-PrivateSubnet3"
    Visibility = "Private"
  }
}

resource "aws_route_table" "PublicRouteTable" {
  vpc_id = aws_vpc.Vpc.id
  tags = {
    Name = "${var.App}-${var.Environment}-PublicRouteTable"
  }
}

resource "aws_route_table" "PrivateRouteTable1" {
  vpc_id = aws_vpc.Vpc.id
  tags = {
    Name = "${var.App}-${var.Environment}-PrivateRouteTable1"
  }

}

resource "aws_route_table" "PrivateRouteTable2" {
  vpc_id = aws_vpc.Vpc.id
  tags = {
    Name = "${var.App}-${var.Environment}-PrivateRouteTable2"
  }
}

resource "aws_route_table" "PrivateRouteTable3" {
  count  = var.EnbaleThreeAzs ? 1 : 0
  vpc_id = aws_vpc.Vpc.id
  tags = {
    Name = "${var.App}-${var.Environment}-PrivateRouteTable3"
  }
}

resource "aws_route_table_association" "PublicSubnet1_Association" {
  route_table_id = aws_route_table.PublicRouteTable.id
  subnet_id      = aws_subnet.PublicSubnet1.id
}

resource "aws_route_table_association" "PublicSubnet2_Association" {
  route_table_id = aws_route_table.PublicRouteTable.id
  subnet_id      = aws_subnet.PublicSubnet2.id
}

resource "aws_route_table_association" "PublicSubnet3_Association" {
  count          = var.EnbaleThreeAzs ? 1 : 0
  route_table_id = aws_route_table.PublicRouteTable.id
  subnet_id      = aws_subnet.PublicSubnet3[count.index].id
}

resource "aws_route_table_association" "PrivateSubnet1_Association" {
  route_table_id = aws_route_table.PrivateRouteTable1.id
  subnet_id      = aws_subnet.PrivateSubnet1.id
}

resource "aws_route_table_association" "PrivateSubnet2_Association" {
  route_table_id = aws_route_table.PrivateRouteTable2.id
  subnet_id      = aws_subnet.PrivateSubnet2.id
}

resource "aws_route_table_association" "PrivateSubnet3_Association" {
  count          = var.EnbaleThreeAzs ? 1 : 0
  route_table_id = aws_route_table.PrivateRouteTable3[count.index].id
  subnet_id      = aws_subnet.PrivateSubnet3[count.index].id
}

resource "aws_eip" "ElasticIpNatGateway1" {
  vpc                       = true
  associate_with_private_ip = var.PrivateSubnet1_Block
  tags = {
    Name = "${var.App}-${var.Environment}-ElasticIpNatGateway1"
  }
}

resource "aws_eip" "ElasticIpNatGateway2" {
  vpc                       = true
  associate_with_private_ip = var.PrivateSubnet2_Block
  tags = {
    Name = "${var.App}-${var.Environment}-ElasticIpNatGateway2"
  }
}

resource "aws_eip" "ElasticIpNatGateway3" {
  count                     = var.EnbaleThreeAzs ? 1 : 0
  vpc                       = true
  associate_with_private_ip = var.PrivateSubnet2_Block
  tags = {
    Name = "${var.App}-${var.Environment}-ElasticIpNatGateway3"
  }
}

resource "aws_nat_gateway" "NatGateway1" {
  allocation_id = aws_eip.ElasticIpNatGateway1.id
  subnet_id     = aws_subnet.PublicSubnet1.id
  tags = {
    Name = "${var.App}-${var.Environment}-NatGateway1"
  }
}

resource "aws_nat_gateway" "NatGateway2" {
  allocation_id = aws_eip.ElasticIpNatGateway2.id
  subnet_id     = aws_subnet.PublicSubnet2.id
  tags = {
    Name = "${var.App}-${var.Environment}-NatGateway2"
  }
}

resource "aws_nat_gateway" "NatGateway3" {
  count         = var.EnbaleThreeAzs ? 1 : 0
  allocation_id = aws_eip.ElasticIpNatGateway3[count.index].id
  subnet_id     = aws_subnet.PublicSubnet3[count.index].id
  tags = {
    Name = "${var.App}-${var.Environment}-NatGateway3"
  }
}

resource "aws_route" "PublicSubnetsRouteToInternet" {
  route_table_id         = aws_route_table.PublicRouteTable.id
  gateway_id             = aws_internet_gateway.InternetGateway.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "PrivateSubnet1_RouteToInternet" {
  route_table_id         = aws_route_table.PrivateRouteTable1.id
  nat_gateway_id         = aws_nat_gateway.NatGateway1.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "PrivateSubnet2_RouteToInternet" {
  route_table_id         = aws_route_table.PrivateRouteTable2.id
  nat_gateway_id         = aws_nat_gateway.NatGateway2.id
  destination_cidr_block = "0.0.0.0/0"
}

resource "aws_route" "PrivateSubnet3_RouteToInternet" {
  count                  = var.EnbaleThreeAzs ? 1 : 0
  route_table_id         = aws_route_table.PrivateRouteTable3[count.index].id
  nat_gateway_id         = aws_nat_gateway.NatGateway3[count.index].id
  destination_cidr_block = "0.0.0.0/0"
}
