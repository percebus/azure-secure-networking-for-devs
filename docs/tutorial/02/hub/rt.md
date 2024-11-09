# Creating a Route Table

## Resources

### Route Table

- Resource group: `{my-prefix}-hub-switzerlandnorth-{id}-rg` (already exists)
  - Route table: `{my-prefix}-hub-switzerlandnorth-{id}-rt`

#### Market place

Look for a "Route table" in the Azure Portal's market place

![Market place](../../../../assets/img/azure/market/rt/logo.png)

#### Create

- **Name**: `{my-prefix}-hub-switzerlandnorth-{id}-rt`
- **Propagate gateway routes**: _"Yes"_

![Create](../../../../assets/img/azure/solution/vnets/hub/rt/create/basics.png)

#### Review + Create

Take a good look at the TERMS

![Review + Create](../../../../assets/img/azure/solution/vnets/hub/rt/create/review.png)

### Routes

#### Drive traffic through the Firewall

> Quiz: _"What is the IP address for 'Every possible IP ot there'?"_

Go to Settings > Routes > Add

![Add](../../../../assets/img/azure/solution/vnets/hub/rt/routes/exit-vnet-thru-fw.png)

- **Route name**: `exit-vnet-thru-fw`
- **Destination type**: _"IP Addresses"_
- **Destination IP addresses/CIDR ranges**: ???
- **Next hop type**: _"Virtual appliance"_ (as in the **Azure Firewall**)
- **Next hop address**: In a new tab, go to the **Azure Firewall** and copy the **Private IP** address
  ![Private IP](../../../../assets/img/azure/solution/vnets/hub/fw/overview.png)

## Finished

[Go back to parent](../README.md)
