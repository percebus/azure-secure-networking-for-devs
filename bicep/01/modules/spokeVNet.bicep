param prefix string
param id string
param spokeLocation string = resourceGroup().location
param addressPrefix string

var basename = '${prefix}-spoke-${spokeLocation}-${id}'

resource spokeNsg 'Microsoft.Network/networkSecurityGroups@2024-03-01' = {
  name: '${basename}-vnet-snet-default-nsg'
  location: spokeLocation
}

resource spokeVNet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: '${basename}-vnet'
  location: spokeLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '${addressPrefix}/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '${addressPrefix}/22' // 10.2.0.0 - 10.2.3.255
          networkSecurityGroup: {
            id: spokeNsg.id
          }
        }
      }
    ]
  }
}

output vNetName string = spokeVNet.name
output vNetId string = spokeVNet.id
