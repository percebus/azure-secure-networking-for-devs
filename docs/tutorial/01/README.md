# Module 1: Virtual Networks

## Table of Contents

1. [Create Hub VNet & resources](./hub.md)
1. [Create Spoke VNet & resources](./spoke.md)
   1. VPN peerings

![Diagram](../../../assets/img/azure/solution/diagrams/01.png)

## Before you begin

### Naming Conventions

Before creating resources, see [Naming conventions](../README.md#naming-conventions).

### Hub & Spoke architecture

Look at the URLs we've included on [Hub-and-Spoke Architectures](../../../README.md#hub-spoke).

This module is part of a series of modules that will help you create a Hub & Spoke network architecture.

The idea is that we can centralize some services to:

- Reduce maintenance loads
- Reduce operational costs (services like **Azure Firewall** and **Azure Bastion** can be expensive!)

At a high level, it looks like this.-

![Hub & Spokes](../../../assets/img/azure/architectures/hub_n_spokes/fw.png)

> _"How is this applicable to ISE?"_ you might ask.

Well, you can have multiple environments (Dev, Test, Prod) in the same subscription, and still keep them isolated.

![Hub & Spokes environments](../../../assets/img/azure/architectures/hub_n_spokes/environments.png)

The above example exceeds the scope of this tutorial, but it's good to know that you can expand on this.

## Status Check

### Diagram

You can visualize the progress of your network

1. Go to any VNet
1. Go to Monitoring > Diagram
1. Expand the components

You should see something like this.-

![Diagram](../../../assets/img/azure/solution/vnets/network/01.png)

## Next Steps

[Go back to parent](../README.md)
