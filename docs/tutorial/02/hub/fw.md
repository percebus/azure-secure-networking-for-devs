# Azure Firewall Rules

Now that all traffic is going through the **Azure Firewall**, we can start adding rules to allow or deny traffic.

## Step 1: Disallow all

Add a rule to disallow all traffic.

- Name: `disallow-all`
- Priority: `100,000`
- Action: _"Deny"_
- Rules
  - IP Addresses:

| name  | Protocol | Source Type | Source | Destination Type | Destination Addresses | Destination Ports |
| ----- | -------- | ----------- | ------ | ---------------- | --------------------- | ----------------- |
| `WWW` | Any      | Any         | `*`    | Any              | `*`                   | `*`               |

Now go to the Jump box, and test that in fact you cannot access anything in the WWW, like `bing.com`

![Deny all](../../../../assets/img/azure/solution/vnets/hub/vm/inside/com/bing/01.png)

## Step 2: Allow some FDQNs

Try to add an allow rule.

- Name: `allow-github`
- Priority: `100`
- Action: _"Allow"_
- Rules
  - FQDNS:

| name         | Protocol | Source Type | Source | Destination FQDNs | Destination Ports |
| ------------ | -------- | ----------- | ------ | ----------------- | ----------------- |
| `GitHub.com` | Any      | Any         | `*`    | `GitHub.com`      | `*`               |

If you get a "You must enable DNS Proxy" error, go to the **Azure Firewall**, go to the next section

## Step 3: Enable DNS Proxy

Uhm, it seems we missed something...

![DNS Proxy must be enabled](../../../../assets/img/azure/solution/vnets/hub/fw/rules/allow-github-disallowed.png)

Oh, so we need to enable the DNS Proxy first!

1. Navigate do DNS
  - [x] Mark "DNS Settings" as "Enabled"
  - [x] Mark "DNS Proxy" as Enabled

![Enable DNS Proxy](../../../../assets/img/azure/solution/vnets/hub/fw/dns/proxy/disabled.png)

Now try to go back to the rules and add the rule again.

## Step 4: Add MORE FQDNs

Yai! \o/
err... success?

![github.com](../../../../assets/img/azure/solution/vnets/hub/vm/inside/com/github/01.png)

Great... Seems that we're able to load **some** `GitHub.com` resources.

If we inspect with Developer tools with <kbd>F11</kbd>, we can see OTHER domains, like `GitHub.GithubAssets.com`.

So keep rinse & repeat until:

- `a)` You're proven youself a point and your learning ego is satisfied and ready to move on.
- or `b)` Your OCD is happy to see the page fully rendered!

`GitHub.com`
![github.com](../../../../assets/img/azure/solution/vnets/hub/vm/inside/com/github/02.png)

`bing.com`
![github.com](../../../../assets/img/azure/solution/vnets/hub/vm/inside/com/bing/02.png)

### Rules

These are all the rules I ended up adding:

![rules](../../../../assets/img/azure/solution/vnets/hub/fw/rules/n.png)

## Finished

[Go back to parent](../README.md)
