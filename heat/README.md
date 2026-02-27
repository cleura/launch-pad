# Cleura Cloud Launch Pad (OpenStack Heat)

## Prerequisites

You'll need the `python-openstackclient`, `python-neutronclient`, and `python-heatclient` packages.
If they are not already installed on your system, you can use `pip` to install them into a Python virtual environment (venv).

In the `heat` subdirectory of your checkout, run the following commands:

```shell
python -m venv launch-pad
source launch-pad/bin/activate
pip install -r requirements.txt
```
## Stack template

In order to launch an OpenStack Heat *stack*, you need a *template*.

The template for your Launch Pad is in the file `template.yaml`.
Do not modify this file.

## Parameters

The template supports multiple *parameters*, where all but one have a reasonable *default* value.

You set the parameters for your Launch Pad in the file `environment.yaml`, in the `parameters` map.
Specifically, you need to set the parameter `ssh_public_key` to your public SSH key:

```yaml
---
parameters:
  ssh_public_key: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL/Gftxrp74jLZJAxmM5ei6Vvq9lHv18DDWws1O9hckX john.doe@example.com"
```

Be sure to replace the value with *your* SSH public key.

## Environment variables

To build your Launch Pad, you need to set `OS_*` environment variables as described in the [Accessing the OpenStack API](https://docs.cleura.cloud/kna1/howto/getting-started/enable-openstack-cli/) section in Cleura Docs.

## Building your Launch Pad

Once you have installed the prerequisite packages, populated your `environment.yaml` file, and set the correct `OS_*` environment variables, you can build your Launch Pad with the following command:

```shell
openstack stack create --wait -t template.yaml -e environment.yaml cleura-cloud-launch-pad
```

Building your Launch Pad should take just a few minutes.

## Accessing your Pad Ramp

Once the Launch Pad has spun up, you can retrieve its details with the following command:
```shell
openstack stack output show -f value -c output_value cleura-cloud-launch-pad details
```

At the end of the output, you will find information on how to connect to your Pad Ramp.
You can then use the `openstack ssh` command to test connectivity:

```console
$ openstack server ssh d194c842-3eb2-42f5-959c-a5030ed60922 -- -l cleura
[...]
Please login as the user "ubuntu" rather than the user "cleura".
```
The correct login name will differ based on the base operating system image.
You can then reconnect using the correct username:

```console
$ openstack server ssh d194c842-3eb2-42f5-959c-a5030ed60922 -- -l ubuntu
Welcome to Ubuntu 24.04.4 LTS (GNU/Linux 6.8.0-101-generic x86_64)
[...]
ubuntu@cleura-cloud-launch-pad-bastion:~$
```
