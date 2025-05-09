resource "qdrant-cloud_accounts_cluster" "this" {
  name           = var.name
  cloud_provider = var.cloud_provider
  cloud_region   = var.region
  configuration {
    number_of_nodes = var.number_of_nodes
    node_configuration {
      package_id = var.node_package_id
    }
  }
}

resource "qdrant-cloud_accounts_auth_key" "this" {
  cluster_ids = [qdrant-cloud_accounts_cluster.this.id]
}
