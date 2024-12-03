@description('The unique short name of the project')
param prefix string

@description('The unique identifier of the current copy, deployment, env, or stack')
param id string

@description('The username to use with the jumpbox')
param jumpBoxUsername string

@secure()
@description('The password to use with the jumpbox username')
param jumpBoxPassword string

@description('The Azure region to deploy the hub to')
param hubLocation string = 'switzerlandnorth'

@description('The Azure regions to deploy the spokes to')
param spokeLocations string[] = ['westus2', 'westeurope']
