# Before you begin

## Table of Contents

> [!TIP]
> Please fully read the following sections before starting the tutorial.

- [Additional Resources](#additional-resources)
- [Azure CLI](#azure-cli)
- [Inconsistent Screenshots](#inconsistent-screenshots)
- [Naming conventions](#naming-conventions)
  - [Example](#example)
- [The Tutorial](#the-tutorial)

## Additional Resources

Be sure to check the [Additional Resources](../README.md#additional-resources) section for more information.

## Azure CLI

Make sure you check this [Azure CLI](./az/cli.md) guide to get familiar with the commands you'll be using.

## Inconsistent screenshots

There are discrepancies w/ the **screenshots** and the **actual information** used in this tutorial.
Please use the information in the markdown (such as **resource names**).

We'll work on updating the images as we refine this training w/ subsequent iterations.

## Naming conventions

`{prefix}-(hub|spoke)-{location}-{id}-{resource type}`

- `prefix`: The shared prefix for all resources in the deployment. i.e.
  - Your username: `johndoe`
  - `nw-security`
- `hub|spoke`: The type of network.
  - `hub`: The central resources `vnet`, for things like **Bastion**, **Firewall**, etc.
  - `spoke`: The regional resources `vnet`, etc.
- `location`: The regional `location` where the resources are deployed. See [locations](./az/locations.md).
- `id`: Something to tell it apart, in case you want to have multiple "stacks" in the same region. Start with `1` or `a`.
  - In case we want to deploy **another** `hub` stack (i.e. `2`), before we delete this one (`1`).
  - This is also useful, if you went w/ something like `nw-security`, but it collides with a resource someone else created.
- `resource type`: The type of resource. i.e. `rg`, `vnet`, `firewall`, etc. See [Resource abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations). Some resources will have chained names, like:
  - `*-vm-special`
  - `*-vm-special-hdd`: [H]ard [D]isk [D]rive
  - `*-vm-special-pep`: [P]rivate [E]nd[p]oint
  - `*-vm-special-pep-nic`: [N]etwork [I]nterfa[c]e

### Example

For a **resource group** in **Switzerland North**, the name would be:

`johndoe-hub-switzerlandnorth-1-rg`

- `johndoe`: The shared prefix for all resources in the deployment.
- `hub`: `hub` or `spoke`
- `switzerlandnorth`: The regional `location` where the resources are deployed.
- `1`: Unique Identifier.
- `rg`: **Resource type**: Resource Group

## The Tutorial

[Head to the tutorial](./tutorial/README.md)
