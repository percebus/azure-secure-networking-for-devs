@description('The unique short name of the project')
param prefix string

@description('The unique identifier of the current copy, deployment, env, or stack')
param id string

@description('The Azure region to deploy the hub to')
param hubLocation string = 'switzerlandnorth'

@description('The Azure regions to deploy the spokes to')
param spokeLocations string[] = ['westus2', 'westeurope']

targetScope = 'subscription'

resource hubRG 'Microsoft.Resources/resourceGroups@2024-07-01' = {
  name: '${prefix}-hub-${hubLocation}-${id}-rg'
  location: hubLocation
}

module hubVNet 'modules/hubVNet.bicep' = {
  name: 'hubVNet'
  scope: hubRG
  params: {
    prefix: prefix
    id: id
    hubLocation: hubLocation
    // addresses start at 10.1.0.0
  }
}

resource spokeRGs 'Microsoft.Resources/resourceGroups@2023-07-01' = [for spokeLocation in spokeLocations: {
  name: '${prefix}-spoke-${spokeLocation}-${id}-rg'
  location: spokeLocation
}]

module spokeVNets 'modules/spokeVNet.bicep' = [for (spokeLocation, i) in spokeLocations: {
  name: 'spokeVNet${i}'
  scope: spokeRGs[i]
  params: {
    prefix: prefix
    id: id
    spokeLocation: spokeLocation
    addressPrefix: '10.${i+2}.0.0'
  }
}]

module hubToSpokePeerings 'modules/vNetPeering.bicep' = [for (spokeLocation, i) in spokeLocations: {
  name: 'hubToSpokePeering${i}'
  scope: hubRG
  params: {
    name: 'hub-${hubLocation}-${id}_to_spoke-${spokeLocation}-${id}'
    fromVNetName: hubVNet.outputs.vNetName
    toVNetId: spokeVNets[i].outputs.vNetId
  }
}]

module spokeToHubPeerings 'modules/vNetPeering.bicep' = [for (spokeLocation, i) in spokeLocations: {
  name: 'spokeToHubPeering${i}'
  scope: spokeRGs[i]
  params: {
    name: 'spoke-${spokeLocation}-${id}_to_hub-${hubLocation}-${id}'
    fromVNetName: spokeVNets[i].outputs.vNetName
    toVNetId: hubVNet.outputs.vNetId
  }
}]

var spokeRGNames = [for (_, i) in spokeLocations: spokeRGs[i].name]
output rgNames array = concat([hubRG.name], spokeRGNames)
