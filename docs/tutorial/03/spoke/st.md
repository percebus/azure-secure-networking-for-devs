# Regional Storage Account

## Description

The information of each short_region is stored in a locally-accessible storage account.

## Goal

1. A Regional storage account in the `spoke` `vnet`, also accessible the **jumpbox** in the `hub` `vnet`.

## Resources

- [R]esource [G]roup: `{prefix}-spoke-{short_region}-{short_id}-rg` (already exists)
  - [V]irtual [N]etwork: `{prefix}-spoke-{short_region}-{short_id}-vnet` (already exists)
    - [S]ubnet: `default` (already exists)
      - [N]etwork [S]ecurity [G]roup: `{prefix}-spoke-{short_region}-{short_id}-nsg` (already exists)
  - (🌟 **new**) [St]orage Account: `{short_prefix}spoke{short_region}{short_id}st`.
    - (🌟 **new**) [P]rivate [E]nd[p]oint: `{short_prefix}spoke{short_region}{short_id}st-pep`
      - (🌟 **new**) [N]etwork [I]nterfa[c]e: `{short_prefix}spoke{short_region}{short_id}st-pep-nic`
      - (🌟 **new**) [A]pplication [S]ecurity [G]roup: `{short_prefix}spoke{short_region}{short_id}st-pep-asg`

Where:

- `{short_prefix}`: Your username (i.e. `johnd`)
- `{short_region}`: The short_region of your spoke VNet (i.e. `wus2`)
- `{short_id}`: The unique identifier of the spoke VNet (i.e. `1`)

### Storage Account

#### Create

##### Basics

Since you just created one **Storage account** at `hub`, we will skim over some details in this part.

- **Storage account name**: `{short_prefix}spoke{short_region}{short_id}st`
- **Redundancy**: Choose "Geo-redundant storage (GRS)", since this will be shared between US and EU.

![Create Storage Account](../../../../assets/img/azure/solution/vnets/spoke/st/create/basics.png)

##### Advanced

![Advanced](../../../../assets/img/azure/solution/vnets/spoke/st/create/advanced.png)

- [x] **Enable storage account key access**: Checked/Selected.
- **Permitted scope of copy operations**: Choose _"Same Microsoft Entra tenant"_.

> [!TIP]
> You can also choose _"From storage accounts that have a **private endpoint** to the same **virtual network**"_.

![Advanced](../../../../assets/img/azure/solution/vnets/hub/st/create/advanced-security.png)

> [!TIP]
> Would a **storage account** in a `spoke` **virtual network** connected via a **private endpoint** through **VNet Private Links** be able to copy data to a **storage account** in the `hub` **virtual network** with this setting?

Something to ponder upon...

##### Networking

> [!IMPORTANT]
> The Storage Account gets shipped with its own Firewall

We've already proven how to close the security. No need to "start Public" and then "Disable" it.

- **Public network access**: Set to "Disable"

![Networking](../../../../assets/img/azure/solution/vnets/spoke/st/create/networking.png)

##### Data protection

![Data protection](../../../../assets/img/azure/solution/vnets/spoke/st/create/data_protection.png)

##### Review

![Review](../../../../assets/img/azure/solution/vnets/spoke/st/create/review.png)

### Storage Account Container

#### Create

Like we did in **Hub**, create a BLOb container.

#### Storage Browser

> [!WARNING]
> You won't be able to access this container from the portal, as we've disallowed **Public Access**.

![Forbidden](../../../../assets/img/azure/solution/vnets/spoke/st/containers/container1/private.png)

### Private Endpoint

Just like in the hub, we will end up with the following names:

- `{storage_account_name}` (JUST created)
  - (🌟 **new**) `{storage_account_name}-pep`
    - (🌟 **new**) `{storage_account_name}-pep-nic`
    - (🌟 **new**) `{storage_account_name}-pep-asg`

#### Create

##### Basics

- **Name**: `{storage_account_name}-pep`
- **Network Interface Name**: `{storage_account_name}-pep-nic`

![Create](../../../../assets/img/azure/solution/vnets/spoke/st/pep/create/basics.png)

##### Resource

- **Resource type**: Choose `Microsoft.Storage/storageAccounts`
- **Resource**: Choose the **storage account** you created in the previous step.
- **Target sub-resource**: Choose _"blob"_.

![Resource](../../../../assets/img/azure/solution/vnets/spoke/st/pep/create/resource.png)

##### Virtual Network

- **Subnet**: Choose the `default` subnet.
- **Private IP Configuration**: Choose _"Dynamically allocate an IP address"_.
- **Application Security Groups**: Create one: `{storage_account_name}-pep-asg`

![Virtual Network](../../../../assets/img/azure/solution/vnets/spoke/st/pep/create/virtual_network.png)

##### DNS

Point to the **Private DNS Zone** created in the previous step.

![DNS](../../../../assets/img/azure/solution/vnets/spoke/st/pep/create/dns.png)

##### Review + create

![Review + create](../../../../assets/img/azure/solution/vnets/spoke/st/pep/create/review.png)

#### Resource Visualizer

You can see the resources you've just created

![Resource Diagram](../../../../assets/img/azure/solution/vnets/spoke/st/pep/resources/01.png)

#### Settings

##### DNS Configuration

It should be registered to the same Private DNS Zone, like we did w/ the one at hub.

![DNS Configuration](../../../../assets/img/azure/solution/vnets/spoke/st/pep/settings/dns_configuration.png)

## Status Check

### From Jumpbox (VM)

#### Terminal

Open a PowerShell terminal run the following command:

```powershell
$> nslookup {your storage}.blob.core.windows.net
```

You should see the name getting resolved

![nslookup](../../../../assets/img/azure/solution/vnets/spoke/st/shell/nslookup.png)

### Storage explorer

If you installed the "Storage Explorer" in the Jumpbox, you should be able to access the storage account from there.

![Emtpy](../../../../assets/img/azure/solution/vnets/spoke/st/explorer/from_jumpbox/empty.png)

You should be able to work with either Storage Account.

![Uploaded](../../../../assets/img/azure/solution/vnets/spoke/st/explorer/from_jumpbox/uploaded.png)

## Next Steps

[Go back to parent](./README.md)
