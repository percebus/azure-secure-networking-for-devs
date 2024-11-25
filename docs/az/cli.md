# azure-secure-networking-for-devs

## Documentation

- [Azure CLI](https://learn.microsoft.com/en-us/cli/azure/)

## Useful Azure CLI commands

- `az`
  - upgrade
  - `account`
    - [list-locations](https://learn.microsoft.com/en-us/cli/azure/account?view=azure-cli-latest#az-account-list-locations)
  - `bicep`
    - install
    - upgrade
  - [deployment](https://learn.microsoft.com/en-us/cli/azure/deployment?view=azure-cli-latest)
    - [sub](https://learn.microsoft.com/en-us/cli/azure/deployment/sub?view=azure-cli-latest)
      - create
      - show
      - delete
  - `group`
    - [delete](https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-delete)
  - `network`
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
  - `resource`
    - [update](https://learn.microsoft.com/en-us/cli/azure/resource?view=azure-cli-latest#az-resource-update)
  - `webapp`
    - vnet-integration
      - [add](https://learn.microsoft.com/en-us/cli/azure/webapp/vnet-integration?view=azure-cli-latest#az-webapp-vnet-integration-add)
