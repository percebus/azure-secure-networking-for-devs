# Creating a Route Table

## Goal

1. Drive all outbound traffic
   1. Going to the internet: through the **Azure Firewall**
   1. Going to other VNets

## Resources

- [R]esource [G]roup: `{my-prefix}-hub-{region}-{id}-rg` (already exists)
  - [R]oute [T]able: `{my-prefix}-hub-{region}-{id}-rt`

Where:

- `{some-short-prefix}`: Your username (i.e. `johndoe`)
- `{region}`: The region of your Hub VNet (i.e. `switzerlandnorth`)
- `{id}`: The unique identifier of the spoke VNet (i.e. `1`)

### Route Table

#### Market place

Look for a "Route table" in the Azure Portal's market place

![Market place](../../../../assets/img/azure/market/rt/logo.png)

#### Create

- **Name**: `{my-prefix}-hub-{region}-{id}-rt`
- **Propagate gateway routes**: _"Yes"_

![Create](../../../../assets/img/azure/solution/vnets/hub/rt/create/basics.png)

#### Review + Create

Take a good look at the TERMS

![Review + Create](../../../../assets/img/azure/solution/vnets/hub/rt/create/review.png)

### Routes

> [!TIP]
> By default, Azure routes traffic between subnets.

We'll add the following route.

| Destinaton Type | IP range  | CIDR ranges | Next hop Type     | Details      |
| --------------- | --------- | ----------- | ----------------- | ------------ |
| IP Addresses    | `x.x.x.x` | `0.0.0.0/0` | Virtual Appliance | `fw` > `WWW` |

#### Drive traffic through the Firewall

First, we need to get the **Private IP** address of the **Azure Firewall**.

1. Go to Firewall > **Overview**
1. Copy the **Private IP** address (in notepad or something)

![Private IP](../../../../assets/img/azure/solution/vnets/hub/fw/overview.png)

We will now redirect Any traffic other than `10.x.x.x` to the WWW through the **Azure Firewall**.

> [!TIP]
> QUIZ: _"What is the IP address for 'Every possible IP ot there'?"_

1. Back in the new route table go to **Settings** > **Routes**
1. Click on [ **+ Add** ]

- **Route name**: `exit-vnet-thru-fw`
- **Destination type**: _"IP Addresses"_
- **Destination IP addresses/CIDR ranges**: `0.0.0.0/0`
- **Next hop type**: _"Virtual appliance"_ (as in the **Azure Firewall**)
- **Next hop address**: Use the **Private IP** address of the **Azure Firewall**

![Add](../../../../assets/img/azure/solution/vnets/hub/rt/routes/exit-vnet-thru-fw.png)

### Associate Route Table with Subnet

1. On the route table > **Settings** > **Associate**

Use the hub network and `default` subnet

![Associate](../../../../assets/img/azure/solution/vnets/hub/rt/routes/associate.png)

## Next Steps

[Configure FireWall](./fw.md)
