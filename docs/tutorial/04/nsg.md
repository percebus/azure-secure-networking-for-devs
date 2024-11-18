# Module 4: NSGs configuration

There will be less hand-holding in this excercise. You will be given a scenario and you will have to figure out the NSG rules to allow the traffic.

## Networking

### Scenarios

#### jumpbox@hub > webapp@default.vnets.{region}.spoke

##### Overview

Since we want the jumpbox (`vm` from the `hub`'s `default` `subnet`) to be able to reach the `webapp` in the `spoke`, we'll need another Private Endpoint that registers to the `privatelink.azurewebsites.net` Private DNS Zone we created in previous step for webapps (not to be confused with the one for blob storage accounts).

##### Network Hops

1. WebApp's Private Endpoint is registered under the Private DNS Zone, with a `10.2.x.x` IP address from the `webapp`'s `default` `subnet`.
1. Jumpbox Asks Azure DNS Resolver to resolve the webapp's DNS name
   1. The Azure DNS Resolver knows about the `privatelink.azurewebsites.net` Private DNS Zone.
   1. The Azure DNS Resolver resolves the webapp's DNS name to a `10.2.x.x` IP address.
1. Jumpbox's request gets proxied via the Hub VNet > VNet Peering > Spoke VNet

##### Keep in mind

1. Hub
   1. `default` subnet: `10.1.x.x`
      1. Jumpbox
         1. NIC: **<<< From HERE**
      1. Private DNS Zone: **<<< Asks IP**
      1. `nsg`:
         1. **Outbound** traffic rules
1. Spoke
   1. `default` VNet: `10.2.x.x`
      1. `nsg`:
         1. **Inbound**
            1. vnet-to-vnet traffic rules
      1. WebApp
         1. Private Endpoint
            1. `asg`
            1. NIC **<<< To HERE**

#### webapp@spoke > storage@spoke

##### Overview

Since we want the webapp (i.e. a `python` app written in `django`) to be able to reach the regional storage account `{some-short-prefix}spoke{region}{id}st`, which is registered under out Private DNS Zone inside the `hub` VNet, this is how it will go:

##### Network Hops

1. Storage Account's Private Endpoint is registered under the Private DNS Zone, with a `10.2.x.x` IP address from the `spoke`'s `default` subnet.
1. Go to the Hub to transform DNS to Private IP
   `webapp` > Delegated Subnet: Create outbound IP. 1. Call gets proxied via the delegated subnet > Spoke VNet > VNet Peering > Hub VNet 1. DNS gets resolved via the Azure DNS Resolver, which knows about the `blobstore` Private DNS Zone to a `10.2.x.x`.
1. WebApp talks directly to the storage account
   1. The WebApp will use the `10.2.x.x` IP address to talk to the storage account.

##### Keep in mind

1. Spoke VNet
   1. WebApp
   1. `webapp` **delegated** `subnet` (not to be confused with `default` `subnet`)
      1. temp IP: **<<< From HERE**
      1. `nsg`:
         1. **Outbound**:
            1. vnet-to-vnet traffic rules
   1. `default` `snet`: `10.2.x.x`
      1. `nsg`:
         1. **Inbound**
            1. Intra-subnet `default` traffic rules
      1. Storage account
         1. Private Endpoint
            1. `asg`
            1. NIC: **<<< To HERE #2**
1. Hub VNet: From Spoke (DNS resolution)
   1. `default` subnet: `10.1.x.x`
      1. `nsg`:
         1. **Inbound**
            1. vnet-to-vnet traffic rules
               1. DNS port protocol: `53`
      1. Private DNS Zone: **<<< To HERE #1**

#### webapp@spoke > storage@hub

##### Overview

We want the webapp (i.e. a `python` app written in `django`) to be able to reach the centralized storage account `{some-short-prefix}hub{region}{id}st`, which is also registered under out Private DNS Zone inside the `hub` VNet.

##### Reminder

Do you recall...?

_"But in the future, were planning to have a web application in the `spoke` `vnet` that we want to add access to the `hub` **storage account**"_

Well, NOW is a good time to go back and add the necessary rules :)
