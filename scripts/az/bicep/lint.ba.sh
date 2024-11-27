#!/bin/bash

set -e

shopt -s globstar
AZ_BICEP_CLI_OPTS="--verbose"

set -x

for filename in ./bicep/**/*.bicep
do
  az bicep lint ${AZ_BICEP_CLI_OPTS} --file $filename
done

set +x
set +e
