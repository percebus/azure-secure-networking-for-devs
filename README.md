# azure-secure-networking-for-devs

## Azure CLI commands

- az
  - network
    - asg
      - [create](https://learn.microsoft.com/en-us/cli/azure/network/asg?view=azure-cli-latest#az-network-asg-create)
    - bastion
      - [create](https://learn.microsoft.com/en-us/cli/azure/network/bastion?view=azure-cli-latest#az-network-bastion-create)
    - [firewall](<https://learn.microsoft.com/en-us/cli/azure/network/firewall?view=azure-cli-latest#az-network-firewall-create(azure-firewall)>)
      - create
      - update
      - [ip-config](<https://learn.microsoft.com/en-us/cli/azure/network/firewall/ip-config?view=azure-cli-latest#az-network-firewall-ip-config-create(azure-firewall)>)
    - nic
      - [create](https://learn.microsoft.com/en-us/cli/azure/network/nic?view=azure-cli-latest#az-network-nic-create)
    - nsg
      - [create](https://learn.microsoft.com/en-us/cli/azure/network/nsg?view=azure-cli-latest#az-network-nsg-create)
      - rule
        - [create](https://learn.microsoft.com/en-us/cli/azure/network/nsg/rule?view=azure-cli-latest#az-network-nsg-rule-create)
    - private-dns
      - link
        - vnet
          - [create](https://learn.microsoft.com/en-us/cli/azure/network/private-dns/link/vnet?view=azure-cli-latest#az-network-private-dns-link-vnet-create)
      - zone
        - [create](https://learn.microsoft.com/en-us/cli/azure/network/private-dns/zone?view=azure-cli-latest#az-network-private-dns-zone-create)
    - private-endpoint
      - [create](https://learn.microsoft.com/en-us/cli/azure/network/private-endpoint?view=azure-cli-latest#az-network-private-endpoint-create)
      - asg
        - [add](https://learn.microsoft.com/en-us/cli/azure/network/private-endpoint/asg?view=azure-cli-latest#az-network-private-endpoint-asg-add)
      - dns-zone-group
        - [add](https://learn.microsoft.com/en-us/cli/azure/network/private-endpoint/dns-zone-group?view=azure-cli-latest#az-network-private-endpoint-dns-zone-group-add)
    - public-ip
      - [create](https://learn.microsoft.com/en-us/cli/azure/network/public-ip?view=azure-cli-latest#az-network-public-ip-create)
    - vm
      - [create](https://learn.microsoft.com/en-us/cli/azure/vm?view=azure-cli-latest#az-vm-create)
      - image
        - [list](https://learn.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest#az-vm-image-list)
    - vnet
      - [create](https://learn.microsoft.com/en-us/cli/azure/network/vnet?view=azure-cli-latest#az-network-vnet-create)
      - [peering](<https://learn.microsoft.com/en-us/cli/azure/network/vnet/peering?view=azure-cli-latest#az-network-vnet-peering-create()>)
      - subnet
        - [create](https://learn.microsoft.com/en-us/cli/azure/network/vnet/subnet?view=azure-cli-latest#az-network-vnet-subnet-create)
  - resource
    - [update](https://learn.microsoft.com/en-us/cli/azure/resource?view=azure-cli-latest#az-resource-update)
  - webapp
    - vnet-integration
      - [add](https://learn.microsoft.com/en-us/cli/azure/webapp/vnet-integration?view=azure-cli-latest#az-webapp-vnet-integration-add)

## Resources

### Networking

- [CIDR to IP v4 Conversion](https://www.ipaddressguide.com/cidr)

### Microsoft

#### Defender

- [What is Microsoft Defender for Cloud?](https://learn.microsoft.com/en-us/azure/defender-for-cloud/defender-for-cloud-introduction)

### Azure

#### Naming Conventions

- [Abbreviation recommendations for Azure resources](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)
- [Naming rules and restrictions for Azure resources](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)

#### Application Gateway

- [What is Azure Application Gateway?](https://learn.microsoft.com/en-us/azure/application-gateway/overview)

#### Bastion

- [What is Azure Bastion?](https://learn.microsoft.com/en-us/azure/bastion/bastion-overview)
- [Quickstart: Deploy Azure Bastion automatically - Basic SKU](https://learn.microsoft.com/en-us/azure/bastion/quickstart-host-portal)

#### DDoS Protection

- [What is Azure DDoS Protection?](https://learn.microsoft.com/en-us/azure/ddos-protection/ddos-protection-overview)

#### Firewall

- [What is Azure Firewall?](https://learn.microsoft.com/en-us/azure/firewall/overview)
- [Choose the right Azure Firewall version to meet your needs](https://learn.microsoft.com/en-us/azure/firewall/choose-firewall-sku)

#### Front Door

- [What is Azure Front Door?](https://learn.microsoft.com/en-us/azure/frontdoor/front-door-overview)

#### Hub-spoke

- [Hub-spoke network topology in Azure](https://learn.microsoft.com/en-us/azure/architecture/networking/architecture/hub-spoke?tabs=cli)

#### Load Balancer

- [What is Azure Load Balancer?](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview)

#### Private

##### DNS zone

- [What is an Azure Private DNS zone?](https://learn.microsoft.com/en-us/azure/dns/private-dns-privatednszone)

##### Endpoint

- [What is a private endpoint?](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)
- [Azure Private Endpoint private DNS zone values](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-dns#private-dns-zone-group)

#### Security Groups

##### [A]pplication [S]ecurity [G]roups

- [Application security groups](https://learn.microsoft.com/en-us/azure/virtual-network/application-security-groups))

##### [N]etwork [S]ecurity [G]roups

- [Network security groups](https://learn.microsoft.com/en-us/azure/virtual-network/network-security-groups-overview)

#### Traffic Manager

- [What is Azure Traffic Manager?](https://learn.microsoft.com/en-us/azure/traffic-manager/traffic-manager-overview)

#### Virtual

##### [VNet]work

- [What is Azure Virtual Network?](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-networks-overview)
- [Quickstart: Use the Azure portal to create a virtual network](https://learn.microsoft.com/en-us/azure/virtual-network/quick-create-portal)

##### Network Peering

- [Virtual network peering](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-peering-overview)

##### Network Link

- [What is a virtual network link?](https://learn.microsoft.com/en-us/azure/dns/private-dns-virtual-network-links)

##### Network Route table

- [Create, change, or delete a route table](https://learn.microsoft.com/en-us/azure/virtual-network/manage-route-table)

##### Network Subnet

- [Add, change, or delete a virtual network subnet](https://learn.microsoft.com/en-us/azure/virtual-network/virtual-network-manage-subnet?tabs=azure-portal)

#### Web Application Firewall

- [What is Azure Web Application Firewall?](https://learn.microsoft.com/en-us/azure/web-application-firewall/overview)
