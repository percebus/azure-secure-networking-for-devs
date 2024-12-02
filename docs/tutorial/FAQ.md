# Tutorial

## Frequently Asked Questions

### Private Endpoints

#### Why

> "Why do we need Private Endpoints"

So like any good question, the answer here is "it depends". But depending on the context for the customer, I might answer with one or more of the following:

- Reduced attack surface for DDOS attacks, etc.
- Total isolation from public internet
- Compliance and regulatory requirements that might require data to never leave the private network
- Integration with on-prem networks
- Simplified network config (e.g. no firewall rules to set up on public endpoints, uses dns-based access)
- Granular access control using ACLs
- Service isolation
- Reduced latency (by avoiding the public internet hops)
- Don't have to worry about public IP address changes that might require config changes on your part
- Simplified access for remote users
