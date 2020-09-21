resource "aws_iam_role" "basic-node" {
  name = "terraform-eks-basic-node"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "basic-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.basic-node.name
}

resource "aws_iam_role_policy_attachment" "basic-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.basic-node.name
}

resource "aws_iam_role_policy_attachment" "basic-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.basic-node.name
}

resource "aws_eks_node_group" "basic" {
  cluster_name    = var.cluster_name
  node_group_name = "basic-node-group"
  node_role_arn   = aws_iam_role.basic-node.arn
  subnet_ids      = [var.public_subnet_id_1, var.public_subnet_id_2, var.public_subnet_id_3]

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.basic-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.basic-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.basic-node-AmazonEC2ContainerRegistryReadOnly,
  ]
}
