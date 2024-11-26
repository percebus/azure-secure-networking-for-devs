param prefix string
param id string
param hubLocation string = resourceGroup().location
param jumpBoxUsername string
@secure()
param jumpBoxPassword string

var basename = '${prefix}-hub-${hubLocation}-${id}'

resource hubNsg 'Microsoft.Network/networkSecurityGroups@2024-03-01' = {
  name: '${basename}-vnet-snet-default-nsg'
  location: hubLocation
}

resource routeTable 'Microsoft.Network/routeTables@2024-03-01' = {
  name: '${basename}-rt'
  location: hubLocation
  properties: {
    disableBgpRoutePropagation: false
  }
}

resource hubVNet 'Microsoft.Network/virtualNetworks@2023-09-01' = {
  name: '${basename}-vnet'
  location: hubLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'AzureBastionSubnet'
        properties: {
          addressPrefix: '10.1.0.0/26' // 10.1.0.0 - 10.1.0.63
        }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: '10.1.1.0/26' // 10.1.1.0 - 10.1.1.63
        }
      }
      {
        name: 'default'
        properties: {
          addressPrefix: '10.1.4.0/22' // 10.1.4.0 - 10.1.7.255
          networkSecurityGroup: {
            id: hubNsg.id
          }
          routeTable:{
            id: routeTable.id
          }
        }
      }
    ]
  }
}

resource bastionSubNet 'Microsoft.Network/virtualNetworks/subnets@2024-03-01' existing = {
  parent: hubVNet
  name: 'AzureBastionSubnet'
}

module bastion 'bastion.bicep' = {
  name: 'bastion'
  params: {
    name: '${basename}-bas'
    location: hubLocation
    subnetId: bastionSubNet.id
  }
}

resource firewallSubNet 'Microsoft.Network/virtualNetworks/subnets@2024-03-01' existing = {
  parent: hubVNet
  name: 'AzureFirewallSubnet'
}

module firewall 'firewall.bicep' = {
  name: 'firewall'
  params: {
    name: '${basename}-fw'
    location: hubLocation
    subnetId: firewallSubNet.id
  }
}

resource wwwRoute 'Microsoft.Network/routeTables/routes@2024-03-01' = {
  parent: routeTable
  name: 'exit-vnet-thru-fw'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: firewall.outputs.privateIp
  }
}

resource defaultSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-03-01' existing = {
  parent: hubVNet
  name: 'default'
}

module jumpBox 'virtualMachine.bicep' = {
  name: 'jumpBox'
  params: {
    vmName: '${basename}-vm-jump'
    location: hubLocation
    subnetId: defaultSubnet.id
    computerName: '${prefix}-hub'
    username: jumpBoxUsername
    password: jumpBoxPassword
  }
}

output vNetName string = hubVNet.name
output vNetId string = hubVNet.id
