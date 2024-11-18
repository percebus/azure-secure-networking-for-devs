# Module 3: Secure Storage Accounts, Hub resources

## Table of Contents

1. Hub
   1. VM
      1. [Download and install Storage Explorer](../storage_explorer.md)
      1. [Create Private DNS Zone](./pdnsz.md)
      1. [Create Storage Account](./st.md)

## Status Check

### Exported

#### CSV

| NAME                                                | TYPE                       | LOCATION          |
| --------------------------------------------------- | -------------------------- | ----------------- |
| {prefix}-hub-{location}-{id}-rt                     | Route table                | Switzerland North |
| {prefix}-hub-{location}-{id}-vm-jump-1              | Virtual machine            | Switzerland North |
| {prefix}-hub-{location}-{id}-vm-jump-133-78550576   | Network Interface          | Switzerland North |
| {prefix}-hub-{location}-{id}-vm-jump-asg            | Application security group | Switzerland North |
| {prefix}-hub-{location}-{id}-vm-jumpOS\_{hash}      | Disk                       | Switzerland North |
| {prefix}-hub-{location}-{id}-vnet                   | Virtual network            | Switzerland North |
| {prefix}-hub-{location}-{id}-vnet-bas               | Bastion                    | Switzerland North |
| {prefix}-hub-{location}-{id}-vnet-bas-pip           | Public IP address          | Switzerland North |
| {prefix}-hub-{location}-{id}-vnet-fw                | Firewall                   | Switzerland North |
| {prefix}-hub-{location}-{id}-vnet-fw-pip            | Public IP address          | Switzerland North |
| {prefix}-hub-{location}-{id}-vnet-snets-default-nsg | Network security group     | Switzerland North |
| {short-prefix}{short-location}1st                   | Storage account            | Switzerland North |
| {short-prefix}{short-location}1st-\_{guid}          | Event Grid System Topic    | Switzerland North |
| {short-prefix}{short-location}1st-pep               | Private endpoint           | Switzerland North |
| {short-prefix}{short-location}1st-pep-asg           | Application security group | Switzerland North |
| {short-prefix}{short-location}1st-pep.nic.{guid}    | Network Interface          | Switzerland North |
| privatelink.blob.core.windows.net                   | Private DNS zone           | Global            |

#### Template

[JSON Template](../../../../azure/templates/hub/03.json)

### Resource Visualizer

![Resources](../../../../assets/img/azure/solution/vnets/hub/resources/01.png)

## Next Steps

[Go back to parent](../README.md)
