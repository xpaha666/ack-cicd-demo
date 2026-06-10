output "cluster_id" {
  value = alicloud_cs_managed_kubernetes.default.id
}

output "kube_config" {
  value     = alicloud_cs_managed_kubernetes.default.kube_config
  sensitive = true
}
