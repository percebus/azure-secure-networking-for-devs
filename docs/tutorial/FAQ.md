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

#### Cost

> "How expensive is private link?"

[Azure Private Link pricing](https://azure.microsoft.com/en-us/pricing/details/private-link/)

##### As of 2024-11-22

It is $0.01/hr + some trivial amount for data processed.

Should you need.-

1. 1 for storage
1. 1 for DB
1. 1 for AI
1. etc.

You're looking at about $7/mo per endpoint plus data (which is negligible if we're not talking about PetaBytes of data)
