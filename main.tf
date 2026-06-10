resource "alicloud_vpc" "default" {
  vpc_name   = var.cluster_name
  cidr_block = "10.1.0.0/21"
}

resource "alicloud_vswitch" "default" {
  vswitch_name = var.cluster_name
  vpc_id       = alicloud_vpc.default.id
  cidr_block   = "10.1.2.0/24"
  zone_id      = "cn-shanghai-b"
}

resource "alicloud_cs_managed_kubernetes" "default" {
  name_prefix          = var.cluster_name
  vswitch_ids          = [alicloud_vswitch.default.id]
  new_nat_gateway      = true
  pod_cidr             = "172.20.0.0/16"
  service_cidr         = "172.21.0.0/20"
  slb_internet_enabled = true
}

resource "alicloud_cs_kubernetes_node_pool" "default" {
  node_pool_name = var.cluster_name
  cluster_id     = alicloud_cs_managed_kubernetes.default.id
  vswitch_ids    = [alicloud_vswitch.default.id]
  instance_types = ["ecs.c6.large"]
  password       = var.node_password
  desired_size   = 2

  system_disk_category = "cloud_essd"
  system_disk_size     = 40
}