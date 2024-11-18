# Creating a Route Table

## Goal

1. Drive all outbound traffic
   1. Going to the internet: through the **Azure Firewall**
   1. Going to other VNets

## Resources

### Route Table

- [R]esource [G]roup: `{my-prefix}-hub-{region}-{id}-rg` (already exists)
  - [R]oute [T]able: `{my-prefix}-hub-{region}-{id}-rt`

Where:

- `{some-short-prefix}`: Your username (i.e. `johndoe`)
- `{region}`: The region of your Hub VNet (i.e. `switzerlandnorth`)
- `{id}`: The unique identifier of the spoke VNet (i.e. `1`)

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

> [!TIP]
> QUIZ: _"What is the IP address for 'Every possible IP ot there'?"_

#### Drive traffic through the Firewall

Go to Settings > Routes > Add

![Add](../../../../assets/img/azure/solution/vnets/hub/rt/routes/exit-vnet-thru-fw.png)

- **Route name**: `exit-vnet-thru-fw`
- **Destination type**: _"IP Addresses"_
- **Destination IP addresses/CIDR ranges**: ???
- **Next hop type**: _"Virtual appliance"_ (as in the **Azure Firewall**)
- **Next hop address**: In a new tab, go to the **Azure Firewall** and copy the **Private IP** address
  ![Private IP](../../../../assets/img/azure/solution/vnets/hub/fw/overview.png)

## Next Steps

[Go back to parent](../README.md)
