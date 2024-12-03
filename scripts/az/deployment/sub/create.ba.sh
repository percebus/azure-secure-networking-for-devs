#!/bin/bash

set -e

deployment_name=${1}
project_folder=${2}
errors=0

if [ -z "${AZURE_DEPLOYMENT_LOCATION}" ]; then
  echo "AZURE_DEPLOYMENT_LOCATION is unset"
  errors=$((errors + 1))
fi

if [ -z "${AZURE_RESOURCES_NAME_PREFIX}" ]; then
  echo "AZURE_RESOURCES_NAME_PREFIX is unset"
  errors=$((errors + 1))
fi

if [ -z "${AZURE_RESOURCES_NAME_ID}" ]; then
  echo "AZURE_RESOURCES_NAME_ID is unset"
  errors=$((errors + 1))
fi

if [ -z "${project_folder}" ]; then
  echo "project_folder is unset"
  errors=$((errors + 1))
fi

if [ -z "${deployment_name}" ]; then
  echo "deployment_name is unset"
  errors=$((errors + 1))
fi

if [[ $errors != 0 ]]; then
  echo "Please set the required environment variables"
  echo "${errors} errors found. Exiting..."
  exit 1
fi

cmd="create"
if [ "${DRY_RUN}" == "1" ]; then
  echo "DRY_RUN: Skipping deployment"
  cmd="what-if"
fi

set -x

file_path=${project_folder}/main.bicep
params_file_path=${project_folder}/main.bicepparam

# SRC: https://learn.microsoft.com/en-us/cli/azure/deployment/sub?view=azure-cli-latest#az-deployment-sub-create
az deployment sub ${cmd} \
  --location ${AZURE_DEPLOYMENT_LOCATION} \
  --name ${deployment_name} \
  --template-file ${file_path} \
  --parameters ${params_file_path} \
  --parameters banana='power'

set +x
set +e
