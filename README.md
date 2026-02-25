# Cleura Cloud Launch Pad

This is a set of essential orchestration configurations you can use to bootstrap a virtual environment on Cleura Cloud.

We support these orchestration frameworks:

* [OpenStack Heat](https://docs.openstack.org/heat/)
* [Ansible](https://docs.ansible.com/) (with the [`openstack.cloud.server`](https://docs.ansible.com/projects/ansible/latest/collections/openstack/cloud/server_module.html) module)
* [OpenTofu](https://opentofu.org/docs/) (with the [`openstack`](https://search.opentofu.org/provider/terraform-provider-openstack/openstack/) provider)

Building a Launch Pad requires a [Cleura Cloud account](https://docs.cleura.cloud/kna1/howto/getting-started/create-account/), and a valid [set of OpenStack API credentials](https://docs.cleura.cloud/kna1/howto/getting-started/enable-openstack-cli/).

Building a Launch Pad results in the creation of these resources:

* A Secure Shell keypair (created from a public key you specify).
* A virtual router with public internet access that is connected to internal networks supporting IPv4 and IPv6.
* Your Pad Ramp, which is a jump host pre-installed with Ubuntu, Debian, or Rocky Linux that you can connect with by Secure Shell.
  You can optionally restrict Secure Shell access to this host to a source IP address or network.

For specifics building a Launch Pad using the orchestration platform of your choice, see the additional notes on [Heat](heat/README.md), [Ansible](ansible/README.md), and [OpenTofu](tf/README.md).

Once you have built your Launch Pad, you can launch further resources from it.
For more details, see [Cleura Docs](https://docs.cleura.cloud).
