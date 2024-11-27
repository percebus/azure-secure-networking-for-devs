# Module 03: Network Security Groups

To get to the NSGs, you will need to

1. Go to (hub|spoke) > Resource Group
1. Go to the `Network Security Group` resource
1. Settings > (Inbound|Outbound) Security Rules

## Goals

1. The **Storage accounts** should only be accessible from the **jumpbox** in the `hub` `vnet`.

## Test Cases

### Storage @ Hub

#### Inbound: Deny ALL

Fist, we need to lock it down.

This is **NOT** _"trust only **buddies**"_, this is **ZERO TRUST**!

Add a **Deny All** rule to the `default` `subnet`'s **NSG**.

- **Name**: `st-deny-all`
  - **Priority**: `1000`ish
  - **Action**: **Deny**
  - **Source**: Any
  - **Destination**:
    - Application Security Group: `{storage_account_name}-pep-asg`

#### Inbound: Allow Some

> [!IMPORTANT]
> Keep reading all the following scenarios.

You will be only doing **ONE** of the following scenarios.
Depending on how venturous you are feeling.

##### Scenario 1: Allow CIDR

You could add an **inbound** rule to allow traffic from our entire `10.x.x.x`

- **Name**: `st-from-cidr-allow`
  - **Priority**: `100`ish
  - **Source**:
    - IP Addresses: `10.0.0.0/8`, this includes.-
      - `hub`'s `vnet` `10.1.x.x`
      - `spoke`'s `vnet` `10.2.x.x`
  - **Destination**:
    - Application Security Group: `{storage_account_name}-pep-asg`

> [!WARNING]
> What happens if a bad actor gets access from a `10.3.4.5` ?

##### Scenario 2: Allow VNets

You could add an **inbound** rule to allow traffic from VNets `10.1.x.x` (hub) and `10.2.x.x` (spoke) explicitly.

- **Name**: `st-from-vnets-allow`
  - **Priority**: `100`ish
  - **Source**:
    - IP Addresses: ~~`10.0.0.0/8`~~
      - `10.1.0.0/16`: `10.1.x.x` `hub` `vnet`
      - `10.2.0.0/16`: `10.2.x.x` `spoke` `vnet`
  - **Destination**:
    - Application Security Group: `{storage_account_name}-pep-asg`

> [!WARNING]
> What happens if a bad actor creates a VM inside `hub`, from a `10.1.8.5` ?

##### Scenario 3: Allow Subnets

Instead of allowing the entire IP Address space of each VNet, we could only allow the `default` `subnet` for each VNet`.

- **Name**: `st-from-subnets-allow`
  - **Priority**: `100`ish
  - **Source**:
    - IP Addresses:
      - ~~`10.1.0.0/16`~~ `10.1.4.0/22`: `10.1.4-7.x` `hub`'s `vnet`'s `default` `subnet`
      - ~~`10.2.0.0/16`~~ `10.2.0.0/22`: `10.2.0-3.x` `spoke`'s `vnet`'s `default` `subnet`
  - **Destination**:
    - Application Security Group: `{storage_account_name}-pep-asg`

> [!WARNING]
> What happens if a bad actor creates a VM with an IP `10.2.3.4`?

##### Scenario 4: Allow JUST Jumpbox

- Remember the ASG we created for the jumpbox(es)? We'll use that instead.
- As for access from `spoke`: _"But in the future, were planning to have a web application in the `spoke` `vnet` that we want to add access to this storage account"_
  - Well, **ONLY THEN** you would add the excemption to allow it, **NEVER BEFORE**.

[Read about YAGNI](https://en.wikipedia.org/wiki/You_aren%27t_gonna_need_it#:~:text=%22You%20aren't%20gonna%20need,add%20functionality%20until%20deemed%20necessary.)

So we end-up with something like this.-

- **Name**: `st-from-jumpbox-allow`
  - **Priority**: `100`ish
  - **Source**:
    - Application Security Group:
      - ~~`10.1.4.0/22`~~ `{jumpbox_name}-pep-asg`
  - **Destination**:
    - Application Security Group: `{storage_account_name}-pep-asg`

<!-- prettier-ignore-start -->
> [!NOTE]
> `10.2.x.x`: Will remain TBD
<!-- prettier-ignore-end  -->

### Storage @ Spoke

#### Inbound: Deny ALL

Like in Hub, we need to lock it down.

Add a **Deny All** rule to the `default` `subnet`'s **NSG**.

- **Name**: `st-deny-all`
  - **Priority**: `1000`ish
  - **Action**: **Deny**
  - **Source**: Any
  - **Destination**:
    - Application Security Group: `{storage_account_name}-pep-asg`

#### Inbound: Allow Jumpbox's subnet

Unfortunately, we can't use **Application Security Group** from other VNets to control access. We'll have to settle for "IP address space" where the **jumpbox** lives.

- **Name**: `st-from-hub-jumpbox-allow`
  - **Priority**: `100`ish
  - **Source**:
    - ~~Application Security Group: `{jumpbox_name}-asg`~~ (if only it were that simple...)
    - **IP Addresses**: ~~`10.1.x.x`~~ `10.1.4.0/22` (`hub`'s `default` `subnet`)
  - **Destination**:
    - **Application Security Group**: `{storage_account_name}-pep-asg`

## Other Test Cases

<!-- prettier-ignore-start -->
> [!IMPORTANT]
> **VERIFY ONLY**
<!-- prettier-ignore-end -->

Not part of this tutorial.

The following is meant to be only educational.

### Storage account(s)

#### Outbound: Allow DNS

**Private Endpoints** will need to be able to **register** with the **Private DNS Zone**.

> [!WARNING]
> The following has not being tested yet.

So **ensure** that the following traffic will be allowed.-

- **Name**: `st-to-hub-dns-allow`
  - **Priority**: `100`ish
  - Source
    - **Application Security Group**: `{storage_account_name}-pep-asg`
  - Destination
    - **Service Tag**: `AzurePlatformDNS`
    - **Destination port ranges**: `53`
    - **Protocol**: `TCP`

For more information on why this is important, see [DNS Vulnerabilities](../../../vulnerabilities.md#dns)

#### Outbound: Deny ALL

> [!IMPORTANT]
> You should take this into account in a **Zero Trust** Production Environment.

But before you eagerly jump to your doom, here are a few of the **many** other things to consider:

- Storage Replicas in other locations/regions
- Storage backups to other storage containers
- **Events** sent via an **Event Grid**
- etc.

Zero Trust sure is hard, right?

## Next Steps

[Go back to parent](./README.md)
