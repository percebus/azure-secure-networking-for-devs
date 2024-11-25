#!/bin/bash

set -e

deployment_name=${1}
project_folder=${2}
errors=0

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

# SRC: https://learn.microsoft.com/en-us/cli/azure/deployment/sub?view=azure-cli-latest#az-deployment-sub-create
az deployment sub ${cmd} \
  --name ${deployment_name} \
  --template-file ${file_path} \
  --parameters prefix=$AZURE_RESOURCES_NAME_PREFIX id=$AZURE_RESOURCES_NAME_ID

set +x
set +e
