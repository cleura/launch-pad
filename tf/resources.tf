resource "openstack_compute_keypair_v2" "keypair" {
  name = "${var.pad_name}-keypair"
  public_key = var.ssh_public_key
}

resource "openstack_networking_network_v2" "network" {
  name = "${var.pad_name}-network"
}

resource "openstack_networking_subnet_v2" "subnet_ipv4" {
  name = "${var.pad_name}-subnet-ipv4"
  network_id = openstack_networking_network_v2.network.id
  ip_version = 4
  cidr = var.ipv4_subnet_cidr
}

resource "openstack_networking_subnet_v2" "subnet_ipv6" {
  count = var.enable_ipv6 ? 1 : 0
  name = "${var.pad_name}-subnet-ipv6"
  network_id = openstack_networking_network_v2.network.id
  ip_version = 6
  subnetpool_id = data.openstack_networking_subnetpool_v2.subnetpool[0].id
  ipv6_address_mode = var.ipv6_mode
  ipv6_ra_mode = var.ipv6_mode
}

resource "openstack_networking_router_v2" "router" {
  name = "${var.pad_name}-router"
  external_network_id = data.openstack_networking_network_v2.external_network.id
}


resource "openstack_networking_router_interface_v2" "router_interface_ipv4" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet_ipv4.id
}

resource "openstack_networking_router_interface_v2" "router_interface_ipv6" {
  count = var.enable_ipv6 ? 1 : 0
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.subnet_ipv6[0].id
}

resource "openstack_networking_secgroup_v2" "security_group" {
  name = "${var.pad_name}-securitygroup"
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule_icmp_ipv4" {
  security_group_id = openstack_networking_secgroup_v2.security_group.id
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "icmp"
  remote_ip_prefix = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule_icmp_ipv6" {
  count = var.enable_ipv6 ? 1 : 0
  security_group_id = openstack_networking_secgroup_v2.security_group.id
  direction = "ingress"
  ethertype = "IPv6"
  protocol = "ipv6-icmp"
  remote_ip_prefix = "::/0"
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule_ssh_ipv4" {
  security_group_id = openstack_networking_secgroup_v2.security_group.id
  direction = "ingress"
  ethertype = "IPv4"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = var.ipv4_allow_access
}

resource "openstack_networking_secgroup_rule_v2" "security_group_rule_ssh_ipv6" {
  count = var.enable_ipv6 ? 1 : 0
  security_group_id = openstack_networking_secgroup_v2.security_group.id
  direction = "ingress"
  ethertype = "IPv6"
  protocol = "tcp"
  port_range_min = 22
  port_range_max = 22
  remote_ip_prefix = var.ipv6_allow_access
}

resource "openstack_networking_port_v2" "bastion_host_port" {
  name = "${var.pad_name}-bastion-port"
  network_id = openstack_networking_network_v2.network.id
  admin_state_up = "true"
  security_group_ids = [openstack_networking_secgroup_v2.security_group.id]
}

resource "openstack_compute_instance_v2" "bastion_host" {
  name = "${var.pad_name}-bastion-host"
  flavor_name = var.flavor
  config_drive = true

  block_device {
    uuid = data.openstack_images_image_v2.image.id
    source_type = "image"
    volume_size = var.volume_size
    boot_index = 0
    destination_type = "volume"
    delete_on_termination = true
  }

  user_data = "${file("cloud-config.yaml")}"
  key_pair = openstack_compute_keypair_v2.keypair.name

  network {
    port = openstack_networking_port_v2.bastion_host_port.id
  }
}

resource "openstack_networking_floatingip_v2" "floating_ip" {
  pool = data.openstack_networking_network_v2.external_network.name
}

resource "openstack_networking_floatingip_associate_v2" "floating_ip_association" {
  floating_ip = openstack_networking_floatingip_v2.floating_ip.address
  port_id     = openstack_networking_port_v2.bastion_host_port.id
  depends_on  = [openstack_networking_router_interface_v2.router_interface_ipv4]
}

