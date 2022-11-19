output "eks_cluster_endpoint" {
  description = "EKS cluster endpoint."
  value       = local.create_eks ? module.eks[0].endpoint : "EKS not created."
}

output "kubeconfig-certificate-authority-data" {
  description = "EKS cluster kubeconfig cert authority data."
  value       = local.create_eks ? module.eks[0].kubeconfig-certificate-authority-data : ""
}
