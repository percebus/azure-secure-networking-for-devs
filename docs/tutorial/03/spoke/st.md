# Regional Storage Account

## Description

The information of each region is stored in a locally-accessible storage account.

## Goal

1. A regional storage account in the `spoke` `vnet`, also accessible the jumpbox in the `hub` `vnet`.

## Resources

- [R]esource [G]roup: `{my-prefix}-spoke-{region}-{id}-rg` (already exists)
  - [V]irtual [N]etwork: `{my-prefix}-spoke-{region}-{id}-vnet` (already exists)
    - [S]ubnet: `default` (already exists)
      - [N]etwork [S]ecurity [G]roup: `{my-prefix}-spoke-{region}-{id}-nsg` (already exists)
  - [St]orage Account: `{some-short-prefix}spoke{region}{id}st`. i.e. `jcspoke{short-location}{short-id}st`.
    - [P]rivate [E]nd[p]oint: `{some-short-prefix}spoke{region}{id}st-pep`
      - [N]etwork [I]nterfa[c]e: `{some-short-prefix}spoke{region}{id}st-pep-nic`
      - [A]pplication [S]ecurity [G]roup: `{some-short-prefix}spoke{region}{id}st-pep-asg`

Where:

- `{some-short-prefix}`: Your username (i.e. `johndoe`)
- `{region}`: The region of your spoke VNet (i.e. `westus2`)
- `{id}`: The unique identifier of the spoke VNet (i.e. `1`)

### Private Endpoint

Creating the "Private Endpoint" and "Network Interface" before-hand will ensure that we end up with the following names:

- `{name}st`
  - `{name}st-pep`
    - `{name}st-pep-nic`

You can also skip this step and either:

1. Go straight to the "Storage Account > Create" and create them from there.
1. Or add them after the fact, which requires more work.

#### Create

##### Basics

![Create](../../../../assets/img/azure/solution/vnets/spoke/st/pep/create/basics.png)

- **Name**: `spoke{region}st-pep`
- **Network Interface Name**: `spoke{region}st-pep-nic`

##### Resource

- **Target sub-resource**: Choose _"blob"_.

##### Virtual Network

- **Subnet**: Choose the `default` subnet.
- **Private IP Configuration**: Choose _"Dynamically allocate an IP address"_.
- **Application Security Groups**: You can go ahead and create one. We will use this to control which resources/IP addresses can access this storage account.

###### DNS

Point to the Private DNS Zone previously created.

#### Resource Visualizer

You can see the resources you've just created

![Resource Diagram](../../../../assets/img/azure/solution/vnets/spoke/st/pep/resources/02.png)

#### Settings

##### DNS Configuration

It should be registered to the same Private DNS Zone, like we did w/ the one at hub.

![DNS Configuration](../../../../assets/img/azure/solution/vnets/spoke/st/pep/settings/dns_configuration.png)

### Storage Account

#### Create

##### Basics

Since you just created one Storage account at hub, we will skim over some details in this part.

![Create Storage Account](../../../../assets/img/azure/solution/vnets/spoke/st/create/basics.png)

##### Networking

> [!IMPORTANT]
> The Storage Account gets shipped with its own Firewall

![Networking](../../../../assets/img/azure/solution/vnets/spoke/st/create/networking.png)

**Network access**: The regional is meant to be private to only the app from that region. We'll still be able to access it from **Hub** via the **Private Endpoint**. Configured below.

**Private Endpoints**: If you have created the "Private Endpoint" before-hand, you can just link it here. If not, this is the step where you could create it:

![Private Endpoint](../../../../assets/img/azure/solution/vnets/spoke/st/create/networking-private_endpoint.png).

> [!WARNING]
> This view does **NOT** allow you to control the name of the "[N]etwork [I]nterfa[c]e". If you want to control the name, you should create the "[P]rivate [E]nd[p]oint" in the step above.

##### Review

![Review](../../../../assets/img/azure/solution/vnets/spoke/st/create/review.png)

## Create a Container

Like we did in **Hub**, create a BLOb container.

> [!Warning]
> You won't be able to access this container from the portal, as we've disallowed **Public Access**.

![Forbidden](../../../../assets/img/azure/solution/vnets/spoke/st/containers/container1/private.png)

### [A]pplication [S]ecurity [G]roup

If you haven't created it so far, you can go ahead and create that now.

#### Market Place

Search for "Application Security Group" in the Azure Portal's Market Place.

![ASG](../../../../assets/img/azure/market/asg/logo.png)

#### Create

And associate to the Storage Account's Private Endpoint

### [N]etwork [S]ecurity [G]roup

#### Inbound Rules

- **Name**: `allow-hub-jumpbox-to-storage`
- **Source**:
  - ~~`{my-prefix}-hub-{region}-{id}-vm-jump-asg`~~ If only it were that simple.
  - We'll have to use `10.1.x.x`
- **Destination**: `{some-short-prefix}spoke{region}{id}st-pep-asg`

#### Create

- **Name**: `{some-short-prefix}spoke{region}{id}st-pep-asg`

And associate with the Storage Account's Private Endpoint `{some-short-prefix}spoke{region}{id}st-pep`

## Status Check

### Exported

#### CSV

| NAME                                                      | TYPE                       | LOCATION  |
| --------------------------------------------------------- | -------------------------- | --------- |
| {short-prefix}{short-location}{short-id}st                | Storage account            | West US 2 |
| {short-prefix}{short-location}{short-id}st-{guid}         | Event Grid System Topic    | West US 2 |
| {short-prefix}{short-location}{short-id}st-pep            | Private endpoint           | West US 2 |
| {short-prefix}{short-location}{short-id}st-pep-asg        | Application security group | West US 2 |
| {short-prefix}{short-location}{short-id}st-pep.nic.{guid} | Network Interface          | West US 2 |

#### Template

[JSON Template](../../../../azure/templates/spoke/03.json)

### Resource Group

![Resource Diagram](../../../../assets/img/azure/solution/vnets/spoke/resources/01.png)

### From Jumpbox (VM)

#### Terminal

Open a PowerShell terminal run the following command:

```
$> nslookup {your storage}.blob.core.windows.net
```

You should see the name getting resolved

![nslookup](../../../../assets/img/azure/solution/vnets/spoke/st/shell/nslookup.png)

### Storage explorer

If you installed the "Storage Explorer" in the Jumpbox, you should be able to access the storage account from there.

![Emtpy](../../../../assets/img/azure/solution/vnets/spoke/st/explorer/from_jumpbox/empty.png)

You should be able to create a text file, and upload it

![Uploaded](../../../../assets/img/azure/solution/vnets/spoke/st/explorer/from_jumpbox/uploaded.png)

## Next Steps

[Go back to parent](../README.md)
