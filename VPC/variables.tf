variable "vpc-cidr-block" {
    description = "CIDR block for the VPC"
    default     = "10.0.0.0/16"
}

variable "public-subnet-cidr-block" {
    description = "CIDR block for the public subnet"
    default = "10.0.1.0/24"
}

variable "private-subnet-cidr-block" {
    description = "CIDR block for the private subnet"
    default = "10.0.2.0/24"
}