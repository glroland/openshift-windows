#!/bin/bash

CONFIG_FILE=env.sh
if ! test -f "$CONFIG_FILE"; then
    echo "ERROR: $CONFIG_FILE does not exist.  Please configure environment before proceeding."
    exit
fi
. $CONFIG_FILE

#sed -i.bak '/$ocp3azw/d' ~/.ssh/known_hosts
az group delete --name $GROUP_NAME -y
az group create --name $GROUP_NAME --location "East US"
az group deployment create \
   --name $GROUP_NAME \
   --resource-group $GROUP_NAME \
   --template-uri $OCP_ARM_TEMPLATE \
     --parameters $PARMS_FILE

#ssh -i $SSH_KEYFILE $ADMIN_USERNAME@$GROUP_NAME.eastus.cloudapp.azure.com bash -c tail install.out

