# Shared Storage Account

## Description

Sometimes you need to share files between different VNets around the world. In this case, you can use a shared storage account to store the files and share them with different VNets.

## Goal

1. A Shared storage account in the `hub` `vnet`, also accessible from the `spoke` `vnet`.
1. The Storage account should only be accessible from the jumpbox in the `hub` `vnet`.

## Naming

Bear in mind that _Storage account_ names are very limited (3-24 chars, no `-` or `_`) & unique across ALL Azure. So unlike other modules, we'll need to simplify the naming for the storage account, and the subsequent resources.

## Resources

- [R]esource [G]roup: `{my-prefix}-hub-{region}-{id}-rg` (already exists)
  - [V]irtual [N]etwork: `{my-prefix}-hub-{region}-{id}-vnet` (already exists)
    - [S]ubnet: `default` (already exists)
      - [N]etwork [S]ecurity [G]roup: `{my-prefix}-hub-{region}-{id}-nsg` (already exists)
  - [St]orage Account: `{some-short-prefix}hub{region}{id}st`. i.e. `jchubswitzerlandnorth1st`.
    - [P]rivate [E]nd[p]oint: `{some-short-prefix}hub{region}{id}st-pep`
      - [N]etwork [I]nterfa[c]e: `{some-short-prefix}hub{region}{id}st-pep-nic`
      - [A]pplication [S]ecurity [G]roup: `{some-short-prefix}hub{region}{id}st-pep-asg`

Where:

- `{some-short-prefix}`: Your username (i.e. `johndoe`)
- `{region}`: The region of your spoke VNet (i.e. `westus2`)
- `{id}`: The unique identifier of the spoke VNet (i.e. `1`)

> [!TIP]
> You can create "Private Endpoint" and "Network interface" in the same step as the "Storage Account" creation, but you **won't have much control over naming**. So We would recommend you start by creating the "Private endpoint".

### Private Endpoint

Creating the "Private Endpoint" and "Network Interface" before-hand will ensure that we end up with the following names:

- `{name}st`
  - `{name}st-pep`
    - `{name}st-pep-nic`

You can also skip this step and either:

1. Go straight to the "Storage Account > Create" and create them from there.
1. Or add them after the fact, which requires more work.

#### Market Place

Search for "Private Endpoint" in the Azure Portal's Market Place.

![Private Endpoint](../../../../assets/img/azure/market/pep/logo.png)

#### Create

##### Basics

![Create](../../../../assets/img/azure/solution/vnets/hub/st/pep/create/basics.png)

- **Name**: `hub{region}st-pep`
- **Network Interface Name**: `hub{region}st-pep-nic`

##### Resource

- **Target sub-resource**: Choose _"blob"_.

![Resource](../../../../assets/img/azure/solution/vnets/hub/st/pep/create/resource.png)

##### Virtual Network

![Virtual Network](../../../../assets/img/azure/solution/vnets/hub/st/pep/create/virtual_network.png)

- **Subnet**: Choose the `default` subnet.
- **Private IP Configuration**: Choose _"Dynamically allocate an IP address"_.
- **Application Security Groups**: You can go ahead and create one. We will use this to control which resources/IP addresses can access this storage account.

###### DNS

Point to the Private DNS Zone created in the previous step.

![DNS](../../../../assets/img/azure/solution/vnets/hub/st/pep/create/dns.png)

#### Settings

DNS configuration:

![DNS configuration](../../../../assets/img/azure/solution/vnets/hub/st/pep/settings/dns.png)

IP configurations:

![IP configurations](../../../../assets/img/azure/solution/vnets/hub/st/pep/settings/ip.png)

### Resources

![Resource Diagram](../../../../assets/img/azure/solution/vnets/hub/st/pep/resources/01.png)

### Storage Account

#### Market Place

Search for "Storage Account" in the Azure Portal's Market Place.

![Storage Account](../../../../assets/img/azure/market/st/logo.png)

#### Create

##### Basics

![Create Storage Account](../../../../assets/img/azure/solution/vnets/hub/st/create/basics.png)

**Storage account name**: `{short-prefix}hub{region}{id}st`

**Primary Service**: Choose "Azure Files".

But be aware that Gen2 is also available.

![Primary Service](../../../../assets/img/azure/solution/vnets/hub/st/create/basics-primary_service-gen2.png)

**Redundancy**: Choose "Geo-redundant storage (GRS)", since this will be shared between US and EU.

![Redundancy](../../../../assets/img/azure/solution/vnets/hub/st/create/basics-redundancy.png)

##### Networking

> [!IMPORTANT]
> The Storage Account gets shipped with its own Firewall

![Networking](../../../../assets/img/azure/solution/vnets/hub/st/create/networking.png)

**Network access**: Choose _"Enable public access from selected virtual networks and IP Addresses"_.

We will start by "poking a hole" and adding our Public IP address to test connectivity, and then proceed to lock it down to the VNet.

**Subnets**: Choose all the subnets available.

![Subnets](../../../../assets/img/azure/solution/vnets/hub/st/create/networking-subnets.png)

- `default`: We want any service from the VNet to be able to access the storage account. We can add more security with ([A]pplication) [S]ecurity [G]roups.
- `AzureBastionSubnet`: We want to be able to access & test the storage account from the Jump box accessible from Bastion.
- ~~`AzureFirewallSubnet`~~: N/A

**IP Addresses**: **TEMPORARY!** Add your current Public IP address. We will be removing this later on.

**Private Endpoints**: If you have created the "Private Endpoint" before-hand, you can just link it here. If not, this is the step where you could create it:

![Private Endpoint](../../../../assets/img/azure/solution/vnets/hub/st/create/networking-private_endpoint.png).

> [!WARNING]
> This view does **NOT** allow you to control the name of the "[N]etwork [I]nterfa[c]e". If you want to control the name, you should create the "[P]rivate [E]nd[p]oint" in the step above.

##### Data protection

![Data protection](../../../../assets/img/azure/solution/vnets/hub/st/create/data_protection.png)

##### Encryption

![Encryption](../../../../assets/img/azure/solution/vnets/hub/st/create/encryption.png)

##### Review

![Review](../../../../assets/img/azure/solution/vnets/hub/st/create/review.png)

#### Settings

##### Configuration

![Configuration](../../../../assets/img/azure/solution/vnets/hub/st/settings/configuration.png)

#### Private Endpoint: Did you forget?

Listen, I get it. We all do mistakes. If you forgot to create the "Private Endpoint" before-hand, or during creation process; you can still do it now.

After adding it, you should see something like this:

![Private endpoint connections](../../../../assets/img/azure/solution/vnets/hub/st/security_n_networking/networking/private_endpoint_connections/approved.png)

#### Reconfigure

Having installed the "Storage Explorer" in both your Jumpbox and your local laptop, you should now be able to connect to this storage account from any of the 2 places:

##### Step 1: Upload data

From Either **Your Laptop** or the **Jumpbox**

1. Open Storage Explorer
1. Create a container
1. Upload a file from your laptop

![Publicly accessible](../../../../assets/img/azure/solution/vnets/hub/st/explorer/from_public/allowed.png)

##### Step 2: Remove Public IP

1. Go to "Security + networking" > "Networking" > "Firewalls and virtual networks" > "Firewall"
1. Remove the Public IP address you added in the previous step.

**Before**:

![Before](../../../../assets/img/azure/solution/vnets/hub/st/security_n_networking/networking/firewall_and_virtual_networks/01.png)

**After**:

![After](../../../../assets/img/azure/solution/vnets/hub/st/security_n_networking/networking/firewall_and_virtual_networks/02.png)

Ideally, we would just change _"Plublic network access"_ to **"Disabled"**. But let's take it 1 step at the time.

###### Step 3: Download data

From your laptop, try to download the file you uploaded in step 1.

You should now see an error like this.-

![Publicly inaccessible](../../../../assets/img/azure/solution/vnets/hub/st/explorer/from_public/disallowed.png)

But it should still work from your Jumpbox `=]`

### Application Security Group

If you haven't created it so far, you can go ahead and create that now.

#### Market Place

Search for "Application Security Group" in the Azure Portal's Market Place.

![ASG](../../../../assets/img/azure/market/asg/logo.png)

### Network Security Group

#### Inbound

> [!IMPORTANT]
> Keep reading all the following scenarios.

You will be only doing **ONE** of the following scenarios.
Depending on how venturous you are feeling.

##### Scenario 1: Minimum security

You could add an **inbound** rule to allow traffic from our entire `10.x.x.x`

- **Name**: `allow-private-to-storage`
- **Source**:
  - `10.0.0.0/8`: This includes
    - `hub`'s vnet `10.1.x.x`
    - `spoke`'s vnet `10.2.x.x`
- **Destination**: `{some-short-prefix}hub{region}{id}st-pep-asg`

> [!IMPORTANT]
> What happens if a bad actor gets access from a `10.3.4.5` ?

##### Scenario 2: More explicit minimum security

You could add an **inbound** rule to allow traffic from our entire `10.x.x.x`

- **Name**: `allow-private-to-storage`
- **Source**:
  - `10.1.0.0/16`
  - `10.2.0.0/16`
- **Destination**: `{some-short-prefix}hub{region}{id}st-pep-asg`

> [!IMPORTANT]
> What happens if a bad actor creates a VM inside `hub`, from a `10.1.4.5` ?

##### Scenario 3: More security

If you want to be more robust, you could

Remember the ASG we created for the jumpboxes (currently only 1)?

- **Name**: `allow-private-to-storage`
- **Source**:
  - `{my-prefix}-hub-{region}-{id}-vm-jump-asg`
  - `10.2.0.0/16`
- **Destination**: `{some-short-prefix}hub{region}{id}st-pep-asg`

> [!WARNING]
> What happens if a bad actor creates a VM with an IP `10.2.3.4`?

##### Scenario 4: Zero Trust

This is **NOT** _"only **buddies** trust"_, this is **ZERO TRUST**!

- _"But in the future, were planning to have a web application in the `spoke` `vnet` that we want to add access to this storage account"_
- Well, then you would add the excemption THEN to allow it. [YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it#:~:text=%22You%20aren't%20gonna%20need,add%20functionality%20until%20deemed%20necessary.)

So we end-up with something like this

- **Name**: `allow-jumpbox-to-storage`
- **Source**:
  - `{my-prefix}-hub-{region}-{id}-vm-jump-asg`
- **Destination**: `{some-short-prefix}hub{region}{id}st-pep-asg`

> [!NOTE] > `10.2.x.x`: Will remain TBD

## Status Check

### Private Endpoint

If you navigate "Resource visualizer", it should show the "[P]rivate [E]nd[p]oint" connected to the "Storage Account". and to the "[N]etwork [I]nterfa[c]e".

![PEP](../../../../assets/img/azure/solution/vnets/hub/st/pep/resources/01.png)

### Private DNS Zone

1. Go to {Your private DNS Zone} > "DNS Management" > "Recordsets"
1. You should see the "A" record pointing to the Private IP address of the "Private Endpoint".

![PEP](../../../../assets/img/azure/solution/vnets/hub/pdnsz/st/dns_management/recordsets.png)

### Jumpbox (VM)

#### Terminal

Open a PowerShell terminal and run the following command:

```
$> nslookup {your storage}.blob.core.windows.net
```

You should see the name getting resolved

#### Storage Explorer

If you installed the "Storage Explorer" in the Jumpbox, you should be able to access the storage account from there.

![Emtpy](../../../../assets/img/azure/solution/vnets/hub/st/explorer/from_jumpbox/empty.png)

You should be able to create a text file, and upload it

## Next Steps

[Go back to parent](./README.md)
