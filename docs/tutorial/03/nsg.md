# Network Security Groups

> [!TIP]
> VERIFY ONLY. No action needed

**Private Endpoints** will need to be able to **register** with the **Private DNS Zone**.

So **ensure** that the following traffic will be allowed.-

## Spoke

> [!WARNING]
> The following has not being tested yet.

Mainly because we're (I'm) NOT 100% sure that working on port `TCP:53` would suffice :p

- `default-nsg`:
  - **Outbound**:
    - Source
      - **IP Addresses**: `10.2.x.x`
      - **Port ranges**: `*`
    - Destination
      - **Service Tag**: `AzurePlatformDNS`
      - **Destination port ranges**: `53`
      - **Protocol**: `TCP` _should_ be enough (right?)

> [!IMPORTANT]
> You should take this into account in a **Zero Trust** Production Environment.

For more information, see [DNS Vulnerabilities](../../../vulnerabilities.md#dns)

## Hub

- `default-nsg`
  - **Outbound**: The shared storage account's
    - Source
      - **IP Addresses**: `10.1.x.x`
      - **Port ranges**: `*`
    - Destination
      - **Service Tag**: `AzurePlatformDNS`
      - **Destination port ranges**: `53`
      - **Protocol**: `TCP`
  - **Inbound**: **Does NOT apply**. the NSG is on the `default` `subnet` level.

Whereas Private DNS Zones are Global, but linked to the VNets as a whole.
