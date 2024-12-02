# azure-secure-networking-for-devs

[`FAQ`s](./FAQ.md)

## Table of Contents

> [!TIP]
> Please fully read the following sections before starting the tutorial.

- [Before you begin](../README.md)
- [Virtual Networks & IP addresses](#virtual-networks--ip-addresses)
- [Goal](#goal)
- [The Tutorial](#the-tutorial)
- [Tear down](#tear-down)
- [FAQs](#faqs)
- [Next Steps](#next-steps)

## Virtual Networks & IP addresses

For simplicity of this excercise, your VNets will look something like:

| Subnet   | Address range | Location           | Notes                         |
| -------- | ------------- | ------------------ | ----------------------------- |
| Hub      | `10.1.x.x`    | `switzerlandnorth` |                               |
| US Spoke | `10.2.x.x`    | `westus2`          |                               |
| EU Spoke | `10.3.x.x`    | `westeurope`       | Not included in this tutorial |

## Goal

![Architecture](../../assets/img/azure/solution/diagrams/n.vsdx.png)

## The Tutorial

Throughout this tutorial, you'll be creating the resources via the following modules:

1. [VNets](./01/README.md)
1. [Jump Box](./02/README.md)
1. [Blob Storage accounts](./03/README.md)
1. [Web App](./04/README.md)

Each will contain a series of Excercises that will guide you through the process of creating the resources.

**Excercises**:

1. Do this
1. Other resource
   1. Do that

When each module is completed, you'll be taken back to the Module's main page, with something like this.-

## Tear down

Once you're done with the tutorial, you should delete the resources you created.
Specially the ones in `hub` as it contains the most expensive resources.

However, you need to tear down the `spoke` resources first, as they depend on the `hub` resources.

### Resources groups order

1. `spoke` resource groups (US, EU, etc.)
1. `hub` resource grup

### Steps

For each Resource Group

1. Go to the Resource Group
1. Click on `[ 🗑 Delete resource group ]`
1. Confirm by typing the name of the Resource Group

## FAQs

Please refer to the [`FAQ`s](./FAQ.md) for more information.

## Next Steps

[Go to parent](#the-tutorial)
