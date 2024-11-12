# Creating and Configuring a Private DNS Zone for Azure Storage Accounts

## Resources

- Private DNS Zone: `privatelink.blob.core.windows.net`
  - Links to VNets
    - `privatelink-at-hub`
    - `privatelink-at-spoke-westus2`

### Private DNS Zone

#### Market place

Look for a "Private DNS Zone" in the Azure Portal's market place

![Market place](../../../../assets/img/azure/market/dnsz/logo.png)

#### Create

##### Basics

![Basics](../../../../assets/img/azure/solution/vnets/hub/dnsz/st/create/basics.png)

- **Name**: `privatelink.blob.core.windows.net`

##### Review + Create

![Review + Create](../../../../assets/img/azure/solution/vnets/hub/dnsz/st/create/review.png)

#### Create VNet Links

1. Go to "DNS Management" > "Virtual Network Links".
1. Click on "Add" and select the VNet to link.

##### VNet: Hub

![Link to Hub VNet](../../../../assets/img/azure/solution/vnets/hub/dnsz/st/vnet/links/hub.png)

- **Link name**: Give a meaningful name to the link, like `privatelink-at-hub`
- **Virtual Network**: Select the **Hub** VNet
- [x] **Enable auto registration**: Click on this checkbox.

##### VNet: Spoke

![Link to Spoke VNet](../../../../assets/img/azure/solution/vnets/hub/dnsz/st/vnet/links/spoke.png)

- **Link name**: Give a meaningful name to the link, like `privatelink-at-hub`
- **Virtual Network**: Select the **Hub** VNet
- [x] **Enable auto registration**: Click on this checkbox.

##### Status Check

Go to "DNS Management" > "Virtual Network Links".

![Virtual Network Links](../../../../assets/img/azure/solution/vnets/hub/dnsz/st/vnet/links/all.png)

## Next Steps

[Go back to parent](../README.md)
