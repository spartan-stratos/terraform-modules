locals {
  manifest = <<YAML
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: "${var.github_org}"
  namespace: argocd
 YAML
}
