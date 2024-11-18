# Module 3: Secure Storage Accounts

## Table of Contents

- [Description](#description)
- [Excercises](#excercises)
- [Next Steps](#next-steps)

## Description

**By default**, _Azure Storage Accounts_ expose **public URLs** (with **public IP addresses**)

It doesn't matter how **private** our VNets are, if we constantly redirect traffic via **public networks**.

## Excercises

> [!IMPORTANT]
> All Storage containers will get registered under `{name}.blob.core.windows.net`

1. Your laptop (Optional)
   1. [Download and install Storage Explorer](./storage_explorer.md)
1. [Hub resouces](hub/README.md)
   1. [Download and install Storage Explorer](./storage_explorer.md) inside the VM
   1. Create Private DNS Zone
   1. Create Storage Account
1. Spoke
   1. [Create Storage Account](spoke/st.md)

![Diagram](../../../assets/img/azure/solution/diagrams/03.png)

## Next Steps

[Go back to parent](../README.md)
