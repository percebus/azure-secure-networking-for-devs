param prefix string
param id string
param hubLocation string = resourceGroup().location
param jumpBoxUsername string
@secure()
param jumpBoxPassword string

var basename = '${prefix}-hub-${hubLocation}-${id}'
var vmName = '${prefix}-hub-${hubLocation}-${id}-vm-jump'

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

resource bastionPublicIP 'Microsoft.Network/publicIPAddresses@2024-03-01' = {
  name: '${basename}-bas-ip'
  location: hubLocation
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource bastionHost 'Microsoft.Network/bastionHosts@2024-03-01' = {
  name: '${basename}-bas'
  location: hubLocation
  properties: {
    ipConfigurations: [
      {
        name: 'IpConf'
        properties: {
          subnet:{
            id: bastionSubNet.id
          }
          publicIPAddress:{
            id: bastionPublicIP.id
          }
        }
      }
    ]
  }
}

resource firewallSubNet 'Microsoft.Network/virtualNetworks/subnets@2024-03-01' existing = {
  parent: hubVNet
  name: 'AzureFirewallSubnet'
}

resource firewallPublicIP 'Microsoft.Network/publicIPAddresses@2024-03-01' = {
  name: '${basename}-fw-ip'
  location: hubLocation
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource firewallPolicy 'Microsoft.Network/firewallPolicies@2024-03-01' = {
  name: 'enable-DNS'
  location: hubLocation
  properties: {
    dnsSettings: {
      enableProxy: true
    }
  }
}

resource firewall 'Microsoft.Network/azureFirewalls@2024-03-01' = {
  name: '${basename}-fw'
  location: hubLocation
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
            id: firewallSubNet.id
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
    // TODO: 1 - fix deployment and 2 - implement one or the other scenario
    networkRuleCollections: [
      {
        name: 'allow-github'
        properties: {
          action: {
            type: 'Allow'
          }
          priority: 100
          rules: [
            {
              name: 'GitHub.com'
              protocols: ['Any']
              sourceAddresses: ['*']
              destinationFqdns: ['GitHub.com']
              destinationPorts: ['*']
            }
            {
              name: '*.GitHub.com'
              protocols: ['Any']
              sourceAddresses: ['*']
              destinationFqdns: ['*.GitHub.com']
              destinationPorts: ['*']
            }
          ]
        }
      }
    ]
  }
}

resource wwwRoute 'Microsoft.Network/routeTables/routes@2024-03-01' = {
  parent: routeTable
  name: 'exit-vnet-thru-fw'
  properties: {
    addressPrefix: '0.0.0.0/0'
    nextHopType: 'VirtualAppliance'
    nextHopIpAddress: firewall.properties.ipConfigurations[0].properties.privateIPAddress
  }
}

resource defaultSubnet 'Microsoft.Network/virtualNetworks/subnets@2024-03-01' existing = {
  parent: hubVNet
  name: 'default'
}

resource asg 'Microsoft.Network/applicationSecurityGroups@2024-03-01' = {
  name: '${vmName}-asg'
  location: hubLocation
}

resource nic 'Microsoft.Network/networkInterfaces@2024-03-01' = {
  name: '${vmName}-nic'
  location: hubLocation
  properties: {
    ipConfigurations: [
      {
        name: 'IPConf'
        properties: {
          subnet: {
            id: defaultSubnet.id
          }
          applicationSecurityGroups: [
            {
              id:asg.id
            }
          ]
        }
      }
    ]
  }
}

resource jumpBox 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: hubLocation
  properties: {
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2022-datacenter-azure-edition-hotpatch'
        version: 'latest'
      }
      osDisk: {
        name: '${vmName}-hdd'
        createOption: 'FromImage'
        deleteOption: 'Delete'
        diskSizeGB: 127
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
        osType: 'Windows'
      }
    }
    hardwareProfile: {
      vmSize: 'Standard_D2s_v3'
    }
    osProfile: {
      computerName: '${prefix}-hub'
      adminUsername: jumpBoxUsername
      adminPassword: jumpBoxPassword
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
          properties: {
            deleteOption: 'Delete'
          }
        }
      ]
    }
  }
}

output vNetName string = hubVNet.name
output vNetId string = hubVNet.id
