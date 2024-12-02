param name string
param location string
param subnetId string

resource firewallPublicIP 'Microsoft.Network/publicIPAddresses@2024-03-01' = {
  name: '${name}-ip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2024-03-01' = {
  name: '${name}-policy'
  location: location
  properties: {
    dnsSettings: {
      enableProxy: true
    }
  }
}

resource firewallRules 'Microsoft.Network/firewallPolicies/ruleCollectionGroups@2024-03-01' = {
  parent: firewallPolicy
  name: '${name}-rules'
  properties: {
    priority: 100
    ruleCollections: [
      {
        ruleCollectionType:'FirewallPolicyFilterRuleCollection'
        name: 'allow-github'
        action: {
          type: 'Allow'
        }
        priority: 100
        rules: [
          {
            ruleType: 'NetworkRule'
            name: 'Github.com'
            ipProtocols: ['Any']
            sourceAddresses: ['*']
            destinationFqdns: ['Github.com']
            destinationPorts: ['*']
          }
          {
            ruleType: 'NetworkRule'
            name: 'Github.GitHubAssets.com'
            ipProtocols: ['Any']
            sourceAddresses: ['*']
            destinationFqdns: ['Github.GitHubAssets.com']
            destinationPorts: ['*']
          }
        ]
      }
    ]
  }
}

resource firewall 'Microsoft.Network/azureFirewalls@2024-03-01' = {
  name: name
  location: location
  properties: {
    sku:{
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    ipConfigurations: [
      {
        name: 'fwIpConf'
        properties: {
          subnet:{
            id: subnetId
          }
          publicIPAddress:{
            id: firewallPublicIP.id
          }
        }
      }
    ]
    firewallPolicy:{
      id: firewallPolicy.id
    }
  }
}

output privateIp string = firewall.properties.ipConfigurations[0].properties.privateIPAddress
