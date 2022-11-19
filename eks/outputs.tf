output "endpoint" {
  description = "EKS cluster endpoint."
  value       = aws_eks_cluster.test_eks_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  description = "EKS cluster kubeconfig cert authority data."
  value       = aws_eks_cluster.test_eks_cluster.certificate_authority[0].data
}
