variable "cluster-name" {
  default = "basic-cluster"
}

variable "public_subnet_id" {
  default = "This should be overridden in the primary main.tf"
}

variable "vpc_security_group_ids" {
  default = "This should be overridden in the primary main.tf"
}