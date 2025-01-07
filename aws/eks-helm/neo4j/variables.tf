variable "chart_version" {
  description = "The version of the Neo4J Helm chart being deployed."
  type        = string
  default     = "0.2.0"
}

variable "helm_release_name" {
  description = "The name of the Helm release for the Neo4J deployment."
  type        = string
  default     = "neo4j"
}

variable "neo4j_password" {
  type        = string
  description = "The password for the Neo4J database."
  default     = null
}

variable "namespace" {
  description = "The Kubernetes namespace where Neo4J will be installed. Defaults to 'neo4j'."
  type        = string
  default     = "neo4j"
}

variable "efs_id" {
  type        = string
  description = "The ID of the EFS (Elastic File System) used for mounting the Neo4J home directory."
}

variable "efs_neo4j_access_point" {
  type        = string
  description = "The specific access point within the EFS for the Neo4J home directory."
  default     = "/neo4j-home"
}

variable "efs_storage_class_name" {
  type        = string
  description = "The storage class name used for Persistent Volumes with EFS."
  default     = "efs"
}

variable "disk_size" {
  type        = string
  description = "The size of the disk to be allocated for Neo4J storage."
  default     = "8Gi"
}

variable "neo4j_fqdn" {
  description = "FQDN of Neo4j service"
  type        = string
  default     = ""
}

variable "domain" {
  description = "The root domain of project"
  type        = string
}

variable "neo4j_dns_name" {
  description = "The Neo4j DNS name"
  type        = string
  default     = "neo4j"
}
