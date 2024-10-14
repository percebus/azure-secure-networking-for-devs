# Route Table

## Resources

### Route Table

#### Market place

Look for a "Route table" in the Azure Portal's market place

![Market place](../../../../assets/img/hub/rt/market/logo.png)

#### Create

![Create](../../../../assets/img/hub/rt/create/basics.png)

- **Name**: `{my-prefix}-hub-switzerlandnorth-{id}-rt`
- **Propagate gateway routes**: _"Yes"_

#### Review + Create

Take a good look at the TERMS

![Review + Create](../../../../assets/img/hub/rt/create/review.png)

### Routes

#### Drive traffic through the Firewall

> Quiz: _"What is the IP address for 'Every possible IP ot there'?"_

Go to Settings > Routes > Add

![Add](../../../../assets/img/hub/rt/routes/exit-vnet-thru-fw.png)

- **Route name**: `exit-vnet-thru-fw`
- **Destination type**: _"IP Addresses"_
- **Destination IP addresses/CIDR ranges**: ???
- **Next hop type**: _"Virtual appliance"_ (as in the **Azure Firewall**)
- **Next hop address**: In a new tab, go to the **Azure Firewall** and copy the **Private IP** address
 ![Private IP](../../../../assets/img/hub/fw/overview.png)
