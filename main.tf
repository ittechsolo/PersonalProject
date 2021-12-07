variable "prix" {}
resource "aws_vpc" "prodVpc" {
    cidr_block = var.prix[0].cidr
    tags = {
      "Name" = var.prix[0].name
    }
  
}
resource "aws_subnet" "prodPubSub" {
    vpc_id = aws_vpc.prodVpc.id
    availability_zone = var.prix[1].AZ
    cidr_block = var.prix[1].cidr
    map_public_ip_on_launch         = true
    tags = {
      "Name" = var.prix[1].name
    }
  
}
resource "aws_subnet" "prodPrvSub" {
    vpc_id = aws_vpc.prodVpc.id
    cidr_block = var.prix[2].cidr
    availability_zone = var.prix[2].AZ
    tags = {
      "Name" = var.prix[2].name
    }
}
resource "aws_internet_gateway" "prodIG" {
    vpc_id = aws_vpc.prodVpc.id
    tags = {
      "Name" = "Prod-IG"
    }
  
 }
 resource "aws_route_table" "prodRT" {
    vpc_id = aws_vpc.prodVpc.id
    depends_on = [aws_internet_gateway.prodIG]
      tags = {
      Name = var.prix[3]
      
    }
 }
  resource "aws_route_table" "prvRT" {
    vpc_id = aws_vpc.prodVpc.id
          tags = {
      Name = var.prix[4]
      
    }

  
}
/*
resource "aws_route" "puR" {
  route_table_id            = aws_route_table.prodRT.id
  gateway_id = aws_internet_gateway.prodIG.id
  destination_cidr_block    = "0.0.0.0/0"
    depends_on                = [aws_route_table.prodRT]
}
resource "aws_route_table_association" "prodRTAssocc" {
     subnet_id = aws_subnet.prodPubSub.id
     route_table_id = aws_route_table.prodRT.id

   
 }
 resource "aws_eip" "prodEIP" {
    vpc = true 

  
}
resource "aws_nat_gateway" "prodNat" {
    allocation_id = aws_eip.prodEIP.id
    subnet_id = aws_subnet.prodPubSub.id
    depends_on = [aws_eip.prodEIP
    ]
    tags = {
      "Name" = "Prod-Nat"
    }
  
}
 resource "aws_route_table" "prodRT" {
    vpc_id = aws_vpc.prodVpc.id
          tags = {
      Name = var.prix[4]
      
    }
resource "aws_route_table" "prvRT" {
    vpc_id = aws_vpc.prodVpc.id 
}
resource "aws_route_table_association" "prvRTAssocc" {
    subnet_id = aws_subnet.prodPrvSub.id
    route_table_id = aws_route_table.prvRT.id 
  
}
resource "aws_route" "prvR" {
  route_table_id             = aws_route_table.prvRT.id
   destination_cidr_block = "0.0.0.0/0"
   nat_gateway_id            = aws_nat_gateway.prodNat.id 
  depends_on                = [aws_route_table.prvRT]
} */