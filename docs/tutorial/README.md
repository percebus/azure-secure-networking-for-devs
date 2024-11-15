# azure-secure-networking-for-devs

> [!Tip]
> Be sure to check "Before you begin" section for additional resources and information.

## Table of Contents

- [The Tutorial](#the-tutorial)
- [Before you begin](#before-you-begin)
  - [Additional Resources](#additional-resources)
  - [Azure CLI](#azure-cli)
  - [Inconsistent Screenshots](#inconsistent-screenshots)
  - [Naming conventions](#naming-conventions)
    - [Example](#example)
- [Virtual Networks & IP addresses](#virtual-networks--ip-addresses)

## The Tutorial

Throughout this tutorial, you'll be creating the resources via the following modules:

1. [VNets](./01/README.md)
1. [Jump Box](./02/README.md)
1. [BLOb Storage accounts](./03/README.md)
1. [Web App](./04/README.md)

And you will be building and configuring this

![Architecture](../../assets/img/azure/solution/diagrams/n.png)

## Before you begin

### Additional Resources

Be sure to check the [Additional Resources](../../README.md#additional-resources) section for more information.

### Azure CLI

Make sure you check this [Azure CLI](../az/cli.md) guide to get familiar with the commands you'll be using.

### Inconsistent screenshots

There are discrepancies w/ the screenshots and the names used in this tutorial.
Please use the names provided in the tutorial, we'll work on updating the images as we refine this training w/ subsequent iterations.

### Naming conventions

`{prefix}-(hub|spoke)-{location}-{id}-{resource type}`

- `prefix`: The shared prefix for all resources in the deployment. i.e.
  - Your username: `johndoe`
  - `nw-security`
- `hub|spoke`: The type of network.
  - `hub`: The central resources `vnet`, for things like **Bastion**, **Firewall**, etc.
  - `spoke`: The regional resources `vnet`, etc.
- `location`: The regional `location` where the resources are deployed. See [locations](../az/locations.md).
- `id`: Something to tell it apart, in case you want to have multiple "stacks" in the same region. Start with `1` or `a`. This is also useful, if you went w/ something like `nw-security`, but it collides with a resource someone else created.
- `resource type`: The type of resource. i.e. `rg`, `vnet`, `firewall`, etc. See [Resource abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations). Some resources will have chained names, like:
  - `*-vm-special`
  - `*-vm-special-hdd`: [H]ard [D]isk [D]rive
  - `*-vm-special-nic`: [N]etwork [I]nterfa[c]e
  - `*-vm-special-nic-pep`: [P]rivate [E]nd[p]oint

#### Example

For a **resource group** in **Switzerland North**, the name would be:

`johndoe-hub-switzerlandnorth-1-rg`

- `johndoe`: The shared prefix for all resources in the deployment.
- `hub`: `hub` or `spoke`
- `switzerlandnorth`: The regional `location` where the resources are deployed.
- `1`: Identifier
- `rg`: **Resource type**: Resource Group

## Virtual Networks & IP addresses

For simplicity of this excercise, your VNets will look something like:

| Subnet   | Address range | Location           | Notes                         |
| -------- | ------------- | ------------------ | ----------------------------- |
| Hub      | `10.1.x.x`    | `switzerlandnorth` |                               |
| US Spoke | `10.2.x.x`    | `westus2`          |                               |
| EU Spoke | `10.3.x.x`    | `westeurope`       | Not included in this tutorial |
