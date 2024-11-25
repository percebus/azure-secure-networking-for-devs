<!-- omit in toc -->

# Bicep Commands

- [Initialize](#initialize)
- [Deploy](#deploy)
- [Destroy](#destroy)
- [Automation](#automation)

## Initialize

Requirements:

- Install azure cli
- Contributor access on an Azure subscription

Install bicep:

```bash
az bicep install
```

or upgrade bicep:

```bash
az upgrade
az bicep upgrade
```

Set your subscription:

```bash
az login
az account set -s $AZURE_SUBSCRIPTION_ID
```

## Deploy

Since we are deploying resource groups, we must deploy at the subscription scope. `--location` is the location to store the deployment metadata and does not affect the location of the deployed resources. `--name` is not required, unless you want to be able to reference the deployment later. You can use the same name for every deployment, unless you want any deployments to run in parallel (only the last deployment of the same name will take).

To test the deployment:

```bash
az deployment sub what-if \
  --location $AZURE_DEPLOYMENT_LOCATION \
  --template-file $PATH_TO_MAIN_FILE \
  --parameters prefix=$AZURE_RESOURCES_NAME_PREFIX id=$AZURE_RESOURCES_NAME_ID
```

To actually deploy:

```bash
az deployment sub create \
  --location $AZURE_DEPLOYMENT_LOCATION \
  --name $AZURE_DEPLOYMENT_NAME \
  --template-file $PATH_TO_MAIN_FILE \
  --parameters prefix=$AZURE_RESOURCES_NAME_PREFIX id=$AZURE_RESOURCES_NAME_ID
```

Optionally, [create a parameters file](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameter-files?tabs=Bicep) to use instead of inline parameters.

```bash
az deployment sub create \
  --location $AZURE_DEPLOYMENT_LOCATION \
  --name $AZURE_DEPLOYMENT_NAME \
  --template-file $PATH_TO_MAIN_FILE \
  --parameters main.bicepparam

#  or
az deployment sub create \
  --location $AZURE_DEPLOYMENT_LOCATION \
  --name $AZURE_DEPLOYMENT_NAME \
  --template-file $PATH_TO_MAIN_FILE \
  --parameters main.parameters.json
```

## Destroy

There isn't really a terraform destroy equivalent. You will need to delete each resource group that was created. `main.bicep` outputs the names of the resource groups it creates.

```bash
az deployment sub show --name $AZURE_DEPLOYMENT_NAME --query properties.outputs.rgNames.value

# will output something like the following:
# [
#   "rg-team-dev-hub",
#   "rg-team-dev-eastus",
#   "rg-team-dev-westeurope"
# ]
```

To delete the resource groups using that output, run the following:

```bash
# add -y to the az group delete command if you don't want to be prompted on each delete
for rg in $(az deployment sub show --name $AZURE_DEPLOYMENT_NAME --query properties.outputs.rgNames.value -o tsv); do az group delete --name $rg --no-wait; done
```

## Automation

We've included some `scripts` to help automate the deployment process.

[See `scripts/az/deployment/sub/README`](../scripts/az/deployment/sub/README.md) for more information.
