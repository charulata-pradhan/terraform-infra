resource "aws_key_pair" "charu_key" {
  key_name   = "charu_key"
  public_key = file("/Users/apple/Desktop/Terraform_Practice/terra-key-charu.pub")
}

resource "aws_default_vpc" "charu_vpc" {}

resource "aws_subnet" "charu_subnet" {
  vpc_id     = aws_default_vpc.charu_vpc.id
  cidr_block = "172.31.0.0/16"
  availability_zone       = "ap-south-1a" # Replace with your region's availability zone
  map_public_ip_on_launch = true
}


resource "aws_security_group" "charu_sg" {
  name        = "allow_ports"
  description = "This SG is open for EC2 instance"
  vpc_id      = aws_default_vpc.charu_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is for SSH"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "This is for outgoing internet"
  }
}

resource "aws_instance" "my_instance" {
  ami               = "ami-0dee22c13ea7a9a67"
  instance_type     = "t2.micro"
  key_name          = aws_key_pair.charu_key.key_name
  subnet_id         = aws_subnet.charu_subnet.id
  security_groups = [aws_security_group.charu_sg.id]

  tags = {
    Name = "charu-terra-instance"
  }
}
