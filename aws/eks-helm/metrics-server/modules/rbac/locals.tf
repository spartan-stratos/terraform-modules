locals {
  namespaces = merge({ for namespace in var.custom_namespaces : namespace => namespace }, { default = "default", "kube-system" = "kube-system" })
}
