# Cleura Cloud Launch Pad (OpenTofu)

## Prerequisites

You'll need the `tofu` command from [OpenTofu](https://opentofu.org) available on your system.

There are multiple ways to install OpenTofu on your system.
Please refer to the [installation instructions](https://opentofu.org/docs/intro/install/) for details.

## Configuration

In order to build your Launch Pad, you need an OpenTofu *configuration*.

Your OpenTofu configuration is in the `.tf` files contained in the `tf` subdirectory of your checkout.
Do not modify these files.

## Variables

The configuration supports multiple *variables*, where all but one have a reasonable *default* value.

You set the variables for your Launch Pad in the file `vars.tfvars`.
Specifically, you need to set the variable `ssh_public_key` to your public SSH key:

```hcl
ssh_public_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL/Gftxrp74jLZJAxmM5ei6Vvq9lHv18DDWws1O9hckX john.doe@example.com"
```

Be sure to replace the value with *your* SSH public key.

## Environment variables

To build your Launch Pad, you need to set `OS_*` environment variables as described in the [Accessing the OpenStack API](https://docs.cleura.cloud/kna1/howto/getting-started/enable-openstack-cli/) section in Cleura Docs.

## Initialising the provider

The OpenTofu configuration relies on the [`openstack`](https://search.opentofu.org/provider/terraform-provider-openstack/openstack/) provider, which you must initialise before applying the configuration for the first time.

You do this with the following command:

```shell
tofu init
```

Provider initialisation should take no more than a few seconds.

## Building your Launch Pad

Once you have installed the prerequisite packages, populated your `vars.tfvars` file, set the correct `OS_*` environment variables, and initialised the provider, you can build your Launch Pad with the following command:

```shell
tofu apply -var-file="vars.tfvars"
```

Building your Launch Pad should take just a few minutes.

## Accessing your Pad Ramp

Once `tofu apply` has completed, you can use the `tofu state show` command to show your Pad Ramp's public ("floating") IP address:

```console
$ tofu state show openstack_networking_floatingip_v2.floating_ip
# openstack_networking_floatingip_v2.floating_ip:
resource "openstack_networking_floatingip_v2" "floating_ip" {
    address   = "192.0.2.146"
    [...]
}
```

You can then use the `ssh` command to test connectivity:

```console
$ ssh cleura@192.0.2.146
[...]
Please login as the user "ubuntu" rather than the user "cleura".
```
The correct login name will differ based on the base operating system image.
You can then reconnect using the correct username:

```console
$ ssh ubuntu@192.0.2.146
Welcome to Ubuntu 24.04.4 LTS (GNU/Linux 6.8.0-101-generic x86_64)
[...]
ubuntu@cleura-cloud-launch-pad-ramp:~$
```

## Tearing down a Launch Pad

In the event that you built a Launch Pad for testing purposes only, **and you have not launched any other cloud resources in your environment,** you might want to tear it down.
To do so, issue the following command:

```console
$ tofu destroy -var-file="vars.tfvars"
[...]
Plan: 0 to add, 0 to change, 16 to destroy.

Do you really want to destroy all resources?
  OpenTofu will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes
```

At the prompt, type `yes` followed by the `Enter` key.
After a minute or so, you will see the following message:

```plain
Destroy complete! Resources: 16 destroyed.
```
