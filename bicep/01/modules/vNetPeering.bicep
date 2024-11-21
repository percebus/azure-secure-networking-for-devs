param name string
param fromVNetName string
param toVNetId string

resource fromVNet 'Microsoft.Network/virtualNetworks@2024-03-01' existing = {
  name: fromVNetName
}

resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2024-03-01' = {
  parent: fromVNet
  name: name
  properties: {
    allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false
    remoteVirtualNetwork: {
      id: toVNetId
    }
  }
}
