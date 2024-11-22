# Bicep Commands

## Initialize

Requirements:

- Install azure cli
- Contributor access on an Azure subscription

Install bicep:

```bash
az bicep install
```

or

```bash
az upgrade
az bicep upgrade
```

Set your subscription:

```bash
az login
az account set -s $SUBSCRIPTION_ID
```

## Deploy

Since we are deploying resource groups, we must deploy at the subscription scope. `--location` is the location to store the deployment metadata and does not affect the location of the deployed resources. `--name` is not required, unless you want to be able to reference the deployment later. You can use the same name for every deployment, unless you want any deployments to run in parallel (only the last deployment of the same name will take).

To test the deployment:

```bash
az deployment sub what-if --location $LOCATION --template-file $PATH_TO_MAIN_FILE --parameters prefix=$PREFIX
```

To actually deploy:

```bash
az deployment sub create --location $LOCATION --name $NAME --template-file $PATH_TO_MAIN_FILE --parameters prefix=$PREFIX
```

## Destroy

There isn't really a terraform destroy equivalent. You will need to delete each resource group that was created. `main.bicep` outputs the names of the resource groups it creates.

```bash
az deployment sub show --name $NAME --query properties.outputs.rgNames.value

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
for rg in $(az deployment sub show --name NetWorkSec --query properties.outputs.rgNames.value -o tsv); do az group delete --name $rg --no-wait; done
```
