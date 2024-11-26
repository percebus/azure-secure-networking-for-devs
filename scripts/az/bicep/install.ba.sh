#!/bin/bash

set -e
set -x

az bicep install
az bicep version

set +x
set +e
