# Developer Guidelines

## General Rules

1. Launch Pads support OpenStack Heat, Ansible, and OpenTofu.
2. Launch Pads must behave substantially identically across all supported orchestration frameworks.
3. Every configuration option must be available, and be named identically, across all supported orchestration frameworks.
4. Every configuration option must be documented in the repository root README.

### Exceptions

* In a Launch Pad built with OpenStack Heat, the `pad_name` variable is replaced by the Heat stack name.

## Supported versions

* The OpenStack stack template supports the OpenStack Caracal, Epoxy, Flamingo, and Gazpacho client libraries.
* The Ansible playbooks support Ansible Core 2.16, 2.19, and 2.20, and the OpenStack Caracal, Epoxy, Flamingo, and Gazpacho client SDKs.
* The OpenTofu configuration supports OpenTofu 1.9, 1.10, and 1.11.

## Style Guide

* YAML files must conform to [yamllint](https://yamllint.readthedocs.io/).
  See `.yamllint` for enabled rules.
* Ansible playbooks must conform to [Ansible Lint](https://docs.ansible.com/projects/lint/) in a default configuration.
* OpenTofu configurations must pass `tf validate` with any supported OpenTofu release.
* Markdown files must use [one sentence per line](https://sive.rs/1s), and conform to [PyMarkdownLnt](https://pymarkdown.readthedocs.io/).
  See `.pymarkdown.json` for enabled rules.

## CI Pipeline

This repo has both a GitLab CI pipeline definition (`.gitlab-ci.yml`) and GitHub Actions Workflows (in `.github/workflows`).

The tests are substantially identical, and use parallel-build matrix strategies to cover the supported platforms.

## Commit Messages

Commit messages must follow the [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/#specification).

## Git Hooks

`commit-msg`, `pre-commit`, `post-commit`, and `pre-push` hooks are available in `.githooks`.
To enable, run this command:

```shell
git config core.hooksPath .githooks
```

## AI Assistance

You may use AI assistance for modifications to this repo.
However, you retain full responsibility for your contribution.

You must declare AI assistance (identifying both the tool and the model you used) in your commit message in an `Assisted-by:` line, as in the following example:

```patch
feat: Add superfrobnication

Add superfrobnication support to all Launch Pads.

Assisted-by: coding-assistant/blerg3.6-coder
```
