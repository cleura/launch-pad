# Cleura Cloud Launch Pad

The [Cleura Cloud Launch Pad](https://github.com/cleura/launch-pad) repository contains a set of essential orchestration configurations you can use to bootstrap a virtual environment on Cleura Cloud.

## Supported frameworks

We support these orchestration frameworks:

* [OpenStack Heat](https://docs.openstack.org/heat/)
* [Ansible](https://docs.ansible.com/) (with the [`openstack.cloud`](https://docs.ansible.com/projects/ansible/latest/collections/openstack/cloud/) collection)
* [OpenTofu](https://opentofu.org/docs/) (with the [`openstack`](https://search.opentofu.org/provider/terraform-provider-openstack/openstack/) provider)

## Prerequisites

Building a Launch Pad requires a [Cleura Cloud account](https://docs.cleura.cloud/kna1/howto/getting-started/create-account/), and a valid [set of OpenStack API credentials](https://docs.cleura.cloud/kna1/howto/getting-started/enable-openstack-cli/).

## What's in a Launch Pad?

Building a Launch Pad results in the creation of these resources:

* A Secure Shell keypair (created from a public key you specify).
* A virtual router with public internet access that is connected to internal networks supporting IPv4 and IPv6.
* Your Pad Ramp, which is a jump host pre-installed with Ubuntu, Debian, or Rocky Linux that you can connect with by Secure Shell.
  You can optionally restrict Secure Shell access to this host to a source IP address or network.

To check out the Launch Pad repository, run this command:

```shell
git clone https://github.com/cleura/launch-pad
```

## Building your Launch Pad

For specifics building a Launch Pad using the orchestration platform of your choice, see the additional notes on [Heat](heat.md), [Ansible](ansible.md), and [OpenTofu](tf.md).

### Configuration options

You can tweak a Launch Pad's configuration by setting options.
Depending on your selected configuration framework, these options are either *parameters* (OpenStack Heat) or *variables* (Ansible, OpenTofu).

Every Launch Pad requires that you specify one option:

| Parameter        | Type   | Purpose                             |
|------------------|--------|-------------------------------------|
| `ssh_public_key` | String | Your Secure Shell (SSH) public key. |

All others come with reasonable defaults:

| Parameter           | Type    | Purpose                                                                                                       | Default                            |
|---------------------|---------|---------------------------------------------------------------------------------------------------------------|------------------------------------|
| `enable_ipv6`       | Boolean | Whether to enable IPv6 in your Launch Pad.                                                                    | `true`                             |
| `image`             | String  | The base operating system image to use for your Pad Ramp.                                                     | `Ubuntu 24.04 Noble Numbat x86_64` |
| `ipv4_allow_access` | String  | An IPv4 address or network from which to allow SSH access to your Pad Ramp.                                   | `0.0.0.0/0` (allow from anywhere)  |
| `ipv4_subnet_cidr`  | String  | The network address for your new private network, in CIDR notation. This can be any RFC 1918 private network. | `192.168.101.0/24`                 |
| `ipv6_allow_access` | String  | An IPv6 address or network from which to allow SSH access to your Pad Ramp.                                   | `::/0` (allow from anywhere)       |

Additional options are available, but you should normally set them only if advised by Cleura's Service Center:

| Parameter         | Type    | Purpose                                                                         | Default            |
|-------------------|---------|---------------------------------------------------------------------------------|--------------------|
| `flavor`          | String  | Your Pad Ramp's instance flavor (a measure of its CPU core and RAM allocation). | `b.2c2gb`          |
| `ipv6_mode`       | String  | The IPv6 address assignment and router advertisement mode for your network.     | `slaac`            |
| `ipv6_subnetpool` | String  | The IPv6 subnetpool from which your IPv6 subnet is created.                     | `ipv6_tenant_pool` |
| `public_net`      | String  | The network name from which your Pad Ramp gets a public IPv4 address.           | `ext-net`          |
| `volume_size`     | Integer | The size of your Pad Ramp's boot device (in GiB).                               | 10                 |

## Where to go from here

Once you have built your Launch Pad, you can [launch further resources from it](https://docs.cleura.cloud/kna1/howto/getting-started/launching-resources/).
