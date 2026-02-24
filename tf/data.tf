data "openstack_images_image_v2" "image" {
  name = var.image
  visibility = "public"
  most_recent = true
}

data "openstack_networking_subnetpool_v2" "subnetpool" {
  name = var.ipv6_subnetpool
  lifecycle {
    enabled = var.enable_ipv6
  }
}

data "openstack_networking_network_v2" "external_network" {
  name = var.public_net
}
