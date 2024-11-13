# Creating and configuring a Private DNS Zone for WebApps

> [!IMPORTANT]
> All webapps will get registered under `{name}.azurewebsites.net`

## Resources

- [R]esource [G]roup: `{my-prefix}-hub-{region}-{id}-rg` (already exists)
  - [P]rivate [DNS] [Z]one: `privatelink.azurewebsites.net`
    - Links to VNets
      - `privatelink-at-hub`
      - `privatelink-at-spoke-westus2`

### Private DNS Zone

#### Market place

Look for a "Private DNS Zone" in the Azure Portal's market place

![Market place](../../../../assets/img/azure/market/pdnsz/logo.png)

#### Create

##### Basics

- **Name**: `privatelink.blob.core.windows.net`

![Basics](../../../../assets/img/azure/solution/vnets/hub/pdnsz/web/create/basics.png)

> [!IMPORTANT]
> All webapps will be registered under `{name}.azurewebsites.net`

##### Review + Create

![Review + Create](../../../../assets/img/azure/solution/vnets/hub/pdnsz/web/create/review.png)

#### Create VNet Links

1. Go to "DNS Management" > "Virtual Network Links".
1. Click on "Add" and select the VNet to link.

##### VNet: Hub

![Link to Hub VNet](../../../../assets/img/azure/solution/vnets/hub/pdnsz/web/vnet/links/hub.png)

- **Link name**: Give a meaningful name to the link, like `privatelink-at-hub`
- **Virtual Network**: Select the **Hub** VNet
- [ ] **Enable auto registration**: Leave this unchecked.

> [!Important]
> You won't be able to register another Private DNS zone under the same VNet if you "enable auto-registration".

![Error](../../../../assets/img/azure/solution/vnets/hub/pdnsz/web/vnet/links/errors/1vnet-to-1pdnsz-auto-registration.png)

##### VNet: Spoke

![Link to Spoke VNet](../../../../assets/img/azure/solution/vnets/hub/pdnsz/web/vnet/links/spoke.png)

- **Link name**: Give a meaningful name to the link, like `privatelink-at-hub`
- **Virtual Network**: Select the **Hub** VNet
- [ ] **Enable auto registration**: Leave this unchecked.

> [!Important]
> You won't be able to register another Private DNS zone under the same VNet if you "enable auto-registration".

##### Status Check

Go to "DNS Management" > "Virtual Network Links".

![Virtual Network Links](../../../../assets/img/azure/solution/vnets/hub/pdnsz/web/vnet/links/all.png)

## Next Steps

[Go back to parent](./README.md)
