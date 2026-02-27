# Cleura Cloud Launch Pad (Ansible)

## Prerequisites

You'll need the `ansible-core` and `openstacksdk` packages, and the `openstack.cloud` Ansible collection.
If they are not already installed on your system, you can use `pip` to install them into a Python virtual environment (venv).

While in this directory (`ansible`), run the following commands:

```console
$ python -m venv launch-pad
$ source launch-pad/bin/activate
$ pip install -r requirements.txt
$ ansible-galaxy collection install -r requirements.yaml
```
## Playbook

In order to build your Launch Pad, you need an Ansible *playbook*.

The playbook for building your Launch Pad is in the file `build.yaml`.
Do not modify this file.

## Variables

The playbook supports multiple *variables*, where all but one have a reasonable *default* value.

You set the variables for your Launch Pad in the file `vars.yaml`.
Specifically, you need to set the variable `ssh_public_key` to your public SSH key:

```yaml
---
ssh_public_key: "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL/Gftxrp74jLZJAxmM5ei6Vvq9lHv18DDWws1O9hckX john.doe@example.com"
```

Be sure to replace the value with *your* SSH public key.

## Environment variables

To build your Launch Pad, you need to set `OS_*` environment variables as described in the [Accessing the OpenStack API](https://docs.cleura.cloud/kna1/howto/getting-started/enable-openstack-cli/) section in Cleura Docs.

## Building your Launch Pad

Once you have installed the prerequisite packages, populated your `vars.yaml` file, and set the correct `OS_*` environment variables, you can build your Launch Pad with the following command:

```shell
ansible-playbook build.yaml
```

Building your Launch Pad should take just a few minutes.

## Accessing your Pad Ramp

At the end of the playbook run, you will see a summary message.

At the end of the output, you will find information on how to connect to your Pad Ramp, specifically its IP addresses.

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
