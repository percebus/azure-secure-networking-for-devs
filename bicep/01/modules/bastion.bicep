param name string
param location string
param subnetId string

resource bastionPublicIP 'Microsoft.Network/publicIPAddresses@2024-03-01' = {
  name: '${name}-ip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource bastionHost 'Microsoft.Network/bastionHosts@2024-03-01' = {
  name: name
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet:{
            id: subnetId
          }
          publicIPAddress:{
            id: bastionPublicIP.id
          }
        }
      }
    ]
  }
}
