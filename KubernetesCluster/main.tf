resource "aws_iam_role" "basic-cluster" {
    name = "IAM role for Terraform Cluster"

    assume_role_policy = <<POLICY
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
        }
    ]
    }
POLICY
}

resource "aws_iam_role_policy_attachment" "basic-cluster-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.basic-cluster.name
}

resource "aws_iam_role_policy_attachment" "basic-cluster-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.basic-cluster.name
}

resource "aws_eks_cluster" "basic-cluster" {
    name = var.cluster-name
    role_arn = aws_iam_role.cluster-role.arn

    vpc_config {
        subnet_id = var.public_subnet_id
        vpc_security_group_ids = [var.vpc_security_group_ids]
    }

    depends_on = [
        aws_iam_role_policy_attachment.demo-cluster-AmazonEKSClusterPolicy,
        aws_iam_role_policy_attachment.demo-cluster-AmazonEKSVPCResourceController,
    ]
}

