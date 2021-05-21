# network.tf

# Fetch AZs in the current region
data "aws_availability_zones" "available" {
}

resource "aws_default_subnet" "default_azs" {
  count                   = var.aws_az_count
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}