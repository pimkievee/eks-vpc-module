

variable "region" {
  default = "us-east-1"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_cidr" {
  description = "CIDR block for the subnet"
  type        = list(string)
  default     = ["10.0.32.0/19", "10.0.96.0/19"]
}

variable "private_cidr" {
  description = "CIDR block for the subnet"
  type        = list(string)
  default     = ["10.0.64.0/19", "10.0.0.0/19"]
}

variable "availability_zone" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "public_key_path" {
  description = "Path to the public key file"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCkELo0xCKhiTpprQX1+OymbKfKPzW0oHwwp/jow7/E0SoJdQSQUydQzN9CnZQk5TXXJH6HQD5v+ECPqtAoCIW5fE264xPqLLlqKLxeS/8dof0y+j6d1LfqO8Z2xCAau23iuMoPNqXXrA2lrJWgykEh3GL+jzhmrJBwBG/Ajov5xNfo00a/lhnMqMzMstZI0uzI9ADXV7N52it2bZcRqdDIx3daYhUDIq2CWY3tr5EydgCg6Wk7Mse8ri30wu/w5kxcnpza1MrykGHthwuYnKUm2aghOSubv/w6lObRJY0diTusZgE22EKLaXfQwlXrXX5fZVGj3Vul6JkuL5f00YDyvXdEL9UJ3LraDqv0fBzWz/nnfvCqvkHZ21kZI+4pg8IyKQbO7FToBT490L1tF8CeNHA4g5TBeQhjhqnVSmUThVm1hFNqulG+C1DlgsVEOOofuQ1amplSWAFWcLT60pV863SobIS88QmR20iF3K6PO1HQh898h873WgAE45AkCi8= valeriebayo@Valeries-Air"
}

variable "instance_ami" {
  description = "AMI for aws instance"
  default     = "ami-03a6eaae9938c858c"
}

variable "instance_type" {
  description = "type for EC2 instance"
  default     = "t2.micro"
}

variable "enviroment_tag" {
  description = "Enviroment tag"
  default     = "production"
}
