# azure-secure-networking-for-devs

## Naming conventions

`{prefix}-(hub|spoke)-{location}-{id}-{resource type}`

- `prefix`: The shared prefix for all resources in the deployment. i.e. `nw-security`
- `hub|spoke`: The type of network.
  - `hub`: The central resources vnet, firewall, etc.
  - `spoke`: The regional resources vnet, etc.
- `location`: The regional `location` where the resources are deployed. See [locations](./locations.md).
- `id`: Something to tell it apart, in case you want to have multiple "stacks" in the same region. Start with `1` or `a`.
- `resource type`: The type of resource. i.e. `rg`, `vnet`, `firewall`, etc. See [Resource abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)

### Example

For a **resource group** in **Switzerland North**, the name would be:

`nw-security-hub-switzerlandnorth-1-rg`

- `nw-security`: The shared prefix for all resources in the deployment.
- `hub`: `hub` or `spoke`
- `switzerlandnorth`: The regional `location` where the resources are deployed.
- `1`: Identifier
- `rg`: **Resource group** type
