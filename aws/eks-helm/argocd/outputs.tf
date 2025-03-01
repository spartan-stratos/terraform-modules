output "argocd_release_name" {
  description = "The name of the Argo CD Helm release"
  value       = helm_release.argocd.name
}

output "argocd_namespace" {
  description = "The namespace where Argo CD is deployed"
  value       = helm_release.argocd.namespace
}

output "argocd_admin_password" {
  value = data.kubernetes_secret.argocd_admin_secret.data["password"]
}
