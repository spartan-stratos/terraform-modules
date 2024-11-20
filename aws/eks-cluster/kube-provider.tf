# data "aws_eks_cluster_auth" "cluster" {
#   name       = local.cluster_name
#   depends_on = [aws_eks_cluster.master]
# }

# provider "kubernetes" {
#   host                   = aws_eks_cluster.master.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.master.certificate_authority.0.data)
#   exec {
#     api_version = "client.authentication.k8s.io/v1beta1"
#     args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.master.name]
#     command     = "aws"
#   }

# }
