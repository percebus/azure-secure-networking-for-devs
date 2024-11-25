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

az deployment sub show --name ${deployment_name}

set +x
set +e
