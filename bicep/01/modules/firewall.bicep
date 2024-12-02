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
  }
}
