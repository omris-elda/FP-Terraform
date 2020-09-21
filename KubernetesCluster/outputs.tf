variable "cluster-name" {
    default = "Basic Cluster"
}

variable "public_subnet_id" {
    default = "This should be overridden in the primary main.tf"
}

variable "vpc_security_group_ids" {
    default = "This should be overridden in the primary main.tf"
}