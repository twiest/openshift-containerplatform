#!/bin/bash -e

cd $(dirname $0)


azure group create opsazuretest01keyvaultrg-eastus eastus
azure keyvault create -u opsazuretest01keyvault -g opsazuretest01keyvaultrg-eastus -l eastus
azure keyvault secret set -u opsazuretest01keyvault -s key1 --file ../azure/azure_rsa
azure keyvault set-policy -u opsazuretest01keyvault --enabled-for-template-deployment true
azure keyvault secret show opsazuretest01keyvault key1
azure group create opsazuretest01rg-eastus eastus


time azure group deployment create --name "opsazuretest01deployment" --resource-group=opsazuretest01rg-eastus --template-file azuredeploy.json -e ../azure/azuredeploy.parameters.json # --nowait
