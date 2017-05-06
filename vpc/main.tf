data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = "${var.cidr}"

  tags {
    Name = "${var.name}-${var.env}"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.name}-${var.env}"
  }
}

resource "aws_subnet" "public" {
  count             = "${length(var.public_subnets)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.public_subnets, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "${var.name}-${var.env}_public"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.name}-${var.env}_public"
  }
}

resource "aws_route" "public" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_subnet" "private" {
  count             = "${length(var.private_subnets)}"
  vpc_id            = "${aws_vpc.main.id}"
  cidr_block        = "${element(var.private_subnets, count.index)}"
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

  tags {
    Name = "${var.name}-${var.env}_private"
  }
}

resource "aws_route_table" "private" {
  count  = "${length(var.private_subnets)}"
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "${var.name}-${var.env}_private"
  }
}

resource "aws_route" "private" {
  count                  = "${length(var.private_subnets)}"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.main.*.id, count.index)}"
}

# NAT resources

resource "aws_eip" "nat" {
  count = "${length(var.public_subnets)}"
  vpc   = true
}

resource "aws_nat_gateway" "main" {
  count         = "${length(var.public_subnets)}"
  allocation_id = "${element(aws_eip.nat.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"

  depends_on = ["aws_internet_gateway.main"]
}
