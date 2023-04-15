output "VpcId" {
  value = aws_vpc.Vpc.id
}

output "PublicSubnet1" {
  value = aws_subnet.PublicSubnet1.id
}

output "PublicSubnet2" {
  value = aws_subnet.PublicSubnet2.id
}

output "PublicSubnet3" {
  value = join("", aws_subnet.PublicSubnet3.*.id)
}

output "PrivateSubnet1" {
  value = aws_subnet.PrivateSubnet1.id
}

output "PrivateSubnet2" {
  value = aws_subnet.PrivateSubnet2.id
}

output "PrivateSubnet3" {
  value = join("", aws_subnet.PrivateSubnet3.*.id)
}

output "CidrBlock" {
  value = aws_vpc.Vpc.cidr_block
}

# VPC - route tables (for mongodb peering)
output "PublicRouteTableId" {
  value = aws_route_table.PublicRouteTable.id
}

output "PrivateRouteTable1Id" {
  value = aws_route_table.PrivateRouteTable1.id
}

output "PrivateRouteTable2Id" {
  value = aws_route_table.PrivateRouteTable2.id
}

output "PrivateRouteTable3Id" {
  value = join("", aws_route_table.PrivateRouteTable3.*.id)
}

# NAT Gateway public Ip's. Used in EKS

output "NatGateway1Ip" {
  value = aws_nat_gateway.NatGateway1.public_ip
}

output "NatGateway2Ip" {
  value = aws_nat_gateway.NatGateway2.public_ip
}

output "NatGateway3Ip" {
  value = join("", aws_nat_gateway.NatGateway3.*.public_ip)
}
