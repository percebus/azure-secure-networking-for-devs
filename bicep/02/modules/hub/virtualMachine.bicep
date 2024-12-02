param vmName string
param location string
param subnetId string
param computerName string
param username string
@secure()
param password string

resource asg 'Microsoft.Network/applicationSecurityGroups@2024-03-01' = {
  name: '${vmName}-asg'
  location: location
}

resource nic 'Microsoft.Network/networkInterfaces@2024-03-01' = {
  name: '${vmName}-nic'
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'IPConf'
        properties: {
          subnet: {
            id: subnetId
          }
          applicationSecurityGroups: [
            {
              id: asg.id
            }
          ]
        }
      }
    ]
  }
}

resource jumpBox 'Microsoft.Compute/virtualMachines@2024-07-01' = {
  name: vmName
  location: location
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
      computerName: computerName
      adminUsername: username
      adminPassword: password
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
