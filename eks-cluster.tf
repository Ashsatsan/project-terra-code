# EKS Cluster
resource "aws_eks_cluster" "my_eks" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]
  }

  # Enable logging for the EKS cluster
  /*enabled_cluster_log_types = [
    "api",
    "audit",
    "controllerManager",
    "scheduler"
  ]*/

  depends_on = [
    aws_iam_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
    aws_iam_policy_attachment.eks_cluster_AmazonEKSServicePolicy
  ]
}

# Node Group
resource "aws_eks_node_group" "my_node_group" {
  cluster_name    = aws_eks_cluster.my_eks.name
  node_group_name = "my-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = [aws_subnet.public_subnet1.id, aws_subnet.public_subnet2.id]

  scaling_config {
    desired_size = var.node_group_size
    max_size     = var.node_group_size + 1
    min_size     = var.node_group_size - 1
  }

  depends_on = [
    aws_eks_cluster.my_eks
  ]
}
