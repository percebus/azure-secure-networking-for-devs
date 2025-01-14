#!/bin/bash

set -e

deployment_name=${1}
errors=0

if [ -z "${deployment_name}" ]; then
  echo "deployment_name is unset"
  errors=$((errors + 1))
fi

if [[ $errors != 0 ]]; then
  echo "Please set the required environment variables"
  echo "${errors} errors found. Exiting..."
  exit 1
fi

set -x

echo "Deleting Resource Groups inside deployment '${deployment_name}'"
for rg in $(az deployment sub show --name $deployment_name --query properties.outputs.rgNames.value -o tsv | tr -d '\r')
do
  # SRC: https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az-group-delete
  az group delete --name $rg --no-wait --yes
done

# After deleting resources
# We removes the deployment by name
# SRC: https://learn.microsoft.com/en-us/cli/azure/deployment/sub?view=azure-cli-latest#az-deployment-sub-delete
echo "Deleting deployment '${deployment_name}'"
az deployment sub delete --name ${deployment_name}

set +x
set +e
