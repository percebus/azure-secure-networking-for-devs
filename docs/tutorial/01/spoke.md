# Spoke VNet

## Description

A "Spoke" VNet is merely a VNet that is connected to a "Hub" VNet to reuse centralized resources, like **Bastion**, **Firewall** or even a shared **Storage Account**.
For this excercise we will only create 1 spoke subnet in the region of your choice. We chose with `westus2` for the US.

## Resources

- Resource Group: `{my-prefix}-spoke-westus2-{id}-rg`
  - VNet: `{my-prefix}-spoke-westus2-{id}-vnet`: `10.2.x.x`
    - Subnets
      - `default`: `10.2.0.x/22`
        - NSG: `{my-prefix}-spoke-westus2-{id}-vnet-snet-default-nsg`

### Resource Group

#### Create

1. Create a `{my-prefix}-spoke-westus2-{id}-rg` resource group in West US 2.
   ![Basics](../../../assets/img/spoke/rg/create/basics.png)

### [V]irtual [Net]work

Just like in the [Hub](./hub.md), we'll create a VNet. But this time, it **WILL NOT** have a **Bastion** or **Firewall**.

#### Create

Name it `{my-prefix}-spoke-westus2-{id}-vnet` in West US 2.

##### Security

Make sure **Bastion** & **Firewall** remained **Toggled OFF**.

![Security](../../../assets/img/spoke/vnet/create/security.png)

###### IP addresses

| Subnet    | IP family | CIDR Block    | Size    | Notes |
| --------- | --------- | ------------- | ------- | ----- |
| `default` | `0-3.x`   | `10.2.0.0/22` | `1,024` |       |

![Security](../../../assets/img/spoke/vnet/create/ip/after.png)

##### Review + Create

Review your settings and create the VNet.

![Review + Create](../../../assets/img/spoke/vnet/create/review.png)

### [N]etwork [S]ecurity [G]roup

1. Create a Network security group
1. Attach it to the `default` subnet.

We'll configure it later down the road

### VNet Peering(s)

Now we have 2 VNets with address spaces `10.1.x.x` & `10.2.x.x`. We need to connect them so the traffic can flow between them.

#### Add Peering

Go to Peerings > Add

FIXME ADD SCREENSHOT

Note that you can allow traffic:

- [x] Hub > Spoke
- [x] Spoke > Hub

For this excercise will check all the boxes.

##### Remote virtual network summary

- Peering link name: `hub-switzerlandnorth-{id}_to_spoke-westus2-{id}`
- Virtual network deployment model: `Resource Manager` (leave it as is)
- Subscription: `{Your subscription}`
- Virtual network: `{my-prefix}-hub-switzerlandnorth-{id}-vnet`

##### Local virtual network summary

- Peering link name: `spoke-westus2-{id}_to_hub-switzerlandnorth-{id}`

##### Remote|Local virtual network peering settings

| Permission                                                                     | Remote | Local |
| ------------------------------------------------------------------------------ | ------ | ----- |
| Allow {that vnet} to access {this vnet}                                        | `x`    | `x`   |
| Allow {that vnet} to receive forwarded traffic from {this vnet}                | `x`    | `x`   |
| Allow gateway or route server in {that vnet} to forward traffic to {this vnet} | `x`    | `x`   |
| Enable {that vnet} tp use {this vnet}'s remote gateway or route server         | `x`    | `x`   |
