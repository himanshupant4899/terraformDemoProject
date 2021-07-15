provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "development-vpc" {
  cidr_block = var.cidr_blocks[0].cidr_block
  tags = {
    Name= var.cidr_blocks[0].name
    vpc_env="dev"
  }
}

resource "aws_subnet" "dev-subnet-1"{
  vpc_id = aws_vpc.development-vpc.id
  cidr_block = var.cidr_blocks[1].cidr_block
  availability_zone = "ap-south-1a"
  tags = {
    Name= var.cidr_blocks[1].name
  }
}

data "aws_vpc" "existing-vpc" {
  default = true
}

resource "aws_subnet" "dev-subnet-2"{
  vpc_id = data.aws_vpc.existing-vpc.id
  cidr_block = "172.31.48.0/20"
  availability_zone = "ap-south-1a"
  tags = {
    Name= "default_subnet"
  }
}

variable "cidr_blocks" {
  description= "vpc cidr block"
  type= list(object({cidr_block=string
                    name=string}))
}


output "dev-vpc-id" {
  value = aws_vpc.development-vpc.id
}

output "dev-subnet-2" {
  value = aws_subnet.dev-subnet-1.id
}