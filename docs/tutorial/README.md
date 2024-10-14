# azure-secure-networking-for-devs

## Before you begin

### Screenshots

There are discrepancies w/ the screenshots and the names used in this tutorial.
Please use the names provided in the tutorial, we'll work on update the images w/ subsequent iterations of this training.

### Naming conventions

`{prefix}-(hub|spoke)-{location}-{id}-{resource type}`

- `prefix`: The shared prefix for all resources in the deployment. i.e.
  - Your username: `jcguerrero`
  - `nw-security`
- `hub|spoke`: The type of network.
  - `hub`: The central resources vnet, firewall, etc.
  - `spoke`: The regional resources vnet, etc.
- `location`: The regional `location` where the resources are deployed. See [locations](../locations.md).
- `id`: Something to tell it apart, in case you want to have multiple "stacks" in the same region. Start with `1` or `a`.
- `resource type`: The type of resource. i.e. `rg`, `vnet`, `firewall`, etc. See [Resource abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations). Some resources will have chained names, like:
  - `*-vm-special`
  - `*-vm-special-hdd`: Disk
  - `*-vm-special-nic`: Network interface
  - `*-vm-special-nic-pep`: Private endpoint

#### Example

For a **resource group** in **Switzerland North**, the name would be:

`jcguerrero-hub-switzerlandnorth-1-rg`

- `jcguerrero`: The shared prefix for all resources in the deployment.
- `hub`: `hub` or `spoke`
- `switzerlandnorth`: The regional `location` where the resources are deployed.
- `1`: Identifier
- `rg`: **Resource group** type

## Table of Contents

1. [VNets](./01/README.md)
1. [Jump Box](./02/README.md)
1. TODO
1. TODO

## Virtual Networks

For simplicity of this excercise, your VNets will look something like:

| Subnet   | Address range | Location           | Notes                         |
| -------- | ------------- | ------------------ | ----------------------------- |
| Hub      | `10.1.x.x`    | `switzerlandnorth` |                               |
| US Spoke | `10.2.x.x`    | `westus2`          |                               |
| EU Spoke | `10.3.x.x`    | `eastus`           | Not included in this tutorial |
