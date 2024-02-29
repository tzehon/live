output "mongo_connection_string" {
  value = mongodbatlas_advanced_cluster.cluster.connection_strings
}