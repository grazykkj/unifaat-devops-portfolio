resource "aws_subnet" "public_a" {
  vpc_id                  = aws_vpc.technova.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = data.aws_availability_zones.available.names[0]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "technova-public-a"
    }
  )
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.technova.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = data.aws_availability_zones.available.names[0]

  tags = merge(
    local.common_tags,
    {
      Name = "technova-private-a"
    }
  )
}

resource "aws_subnet" "public_b" {
  vpc_id                  = aws_vpc.technova.id
  cidr_block              = "10.0.3.0/24"
  availability_zone       = data.aws_availability_zones.available.names[1]
  map_public_ip_on_launch = true

  tags = merge(
    local.common_tags,
    {
      Name = "technova-public-b"
    }
  )
}

resource "aws_subnet" "private_b" {
  vpc_id            = aws_vpc.technova.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = data.aws_availability_zones.available.names[1]

  tags = merge(
    local.common_tags,
    {
      Name = "technova-private-b"
    }
  )
}
resource "aws_internet_gateway" "technova" {
  vpc_id = aws_vpc.technova.id

  tags = merge(
    local.common_tags,
    {
      Name = "technova-igw"
    }
  )
}
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.technova.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.technova.id
  }

  tags = merge(
    local.common_tags,
    {
      Name = "technova-public-rt"
    }
  )
}
resource "aws_route_table_association" "public_a" {
  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_b" {
  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}
