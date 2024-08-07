variable "private_cidr" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "public_cidr" {
  type = list(string)
}

variable "region" {
  type = list(string)
}

variable "environment" {
  type = list(string)
}

variable "cidr_block" {
  type = string
}

variable "log_destination" {
  type = string
}

variable "log_destination_type" {
  type = string
}

variable "vpc_name" {
  type = string
}