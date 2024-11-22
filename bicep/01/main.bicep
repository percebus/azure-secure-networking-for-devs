@description('The unique short name of the project')
param prefix string

@description('The Azure region to deploy the hub to')
param hubLocation string = 'switzerlandnorth'

@description('The Azure regions to deploy the spokes to')
param spokeLocations string[] = ['westus2', 'westeurope']

targetScope = 'subscription'

resource hubRG 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: '${prefix}-hub-${hubLocation}-0-rg'
  location: hubLocation
}

module hubVNet 'modules/hubVNet.bicep' = {
  name: 'hubVNet'
  scope: hubRG
  params: {
    prefix: prefix
    hubLocation: hubLocation
    // addresses start at 10.1.0.0
  }
}

resource spokeRGs 'Microsoft.Resources/resourceGroups@2023-07-01' = [for (spokeLocation, i) in spokeLocations: {
  name: '${prefix}-spoke-${spokeLocation}-${i+1}-rg'
  location: spokeLocation
}]

module spokeVNets 'modules/spokeVNet.bicep' = [for (spokeLocation, i) in spokeLocations: {
  name: 'spokeVNet${i+1}'
  scope: spokeRGs[i]
  params: {
    prefix: prefix
    spokeLocation: spokeLocation
    id: i+1
    addressPrefix: '10.${i+2}.0.0'
  }
}]

module hubToSpokePeerings 'modules/vNetPeering.bicep' = [for (spokeLocation, i) in spokeLocations: {
  name: 'hubToSpokePeering${i+1}'
  scope: hubRG
  params: {
    name: 'hub-${hubLocation}-0_to_spoke-${spokeLocation}-${i+1}'
    fromVNetName: hubVNet.outputs.vNetName
    toVNetId: spokeVNets[i].outputs.vNetId
  }
}]

module spokeToHubPeerings 'modules/vNetPeering.bicep' = [for (spokeLocation, i) in spokeLocations: {
  name: 'spokeToHubPeering${i+1}'
  scope: spokeRGs[i]
  params: {
    name: 'spoke-${spokeLocation}-${i+1}_to_hub-${hubLocation}-0'
    fromVNetName: spokeVNets[i].outputs.vNetName
    toVNetId: hubVNet.outputs.vNetId
  }
}]

var spokeRGNames = [for (_, i) in spokeLocations: spokeRGs[i].name]
output rgNames array = concat([hubRG.name], spokeRGNames)
