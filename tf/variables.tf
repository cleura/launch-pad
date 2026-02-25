variable "pad_name" {
  type = string
  description = "Name assigned to the pad"
  default = "cleura-cloud-launch-pad"
}
variable "ssh_public_key" {
  type = string
  description = "Public Secure Shell (SSH) key"
}
variable "public_net" {
  type = string
  description = "Name of the external network providing an internet connection"
  default = "ext-net"
}
variable "enable_ipv6" {
  type = bool
  description = "Enable IPv6 support for the virtual network"
  default = true
}
variable "ipv4_subnet_cidr" {
  type = string
  description = "Private IPv4 network mask, in CIDR notation"
  default = "192.168.101.0/24"
}
variable "ipv4_allow_access" {
  type = string
  description = "Allowed source IPv4 address or network for management access"
  default = "0.0.0.0/0"
}
variable "ipv6_subnetpool" {
  type = string
  description = "IPv6 subnet pool"
  default = "ipv6_tenant_pool"
}
variable "ipv6_mode" {
  type = string
  description = "IPv6 address assignment and router advertisement mode"
  default = "slaac"
}
variable "ipv6_allow_access" {
  type = string
  description = "Allowed source IPv6 address or network for management access"
  default = "::/0"
}
variable "image" {
  type = string
  description = "Base image to use for the Pad Ramp"
  default = "Ubuntu 24.04 Noble Numbat x86_64"
}
variable "volume_size" {
  type = number
  description = "Storage space allocated to the Pad Ramp (GiB)"
  default = 10
}
variable "flavor" {
  type = string
  description = "Flavor to use for the Pad Ramp"
  default = "b.2c2gb"
}
