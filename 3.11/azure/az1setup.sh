#!/bin/bash

CONFIG_FILE=env.sh
if ! test -f "$CONFIG_FILE"; then
    echo "ERROR: $CONFIG_FILE does not exist.  Please configure environment before proceeding."
    exit
fi
. $CONFIG_FILE

rm -f $PARMS_FILE
cp $PARMS_TEMPLATE_FILE $PARMS_FILE
sed -i '' -e  "s/GROUP_NAME/$GROUP_NAME/g" "$PARMS_FILE"
sed -i '' -e  "s/ADMIN_USERNAME/$ADMIN_USERNAME/g" "$PARMS_FILE"
sed -i '' -e  "s/ADMIN_PASSWORD/$ADMIN_PASSWORD/g" "$PARMS_FILE"
sed -i '' -e  "s/RHN_USERNAME/$RHN_USERNAME/g" "$PARMS_FILE"
sed -i '' -e  "s/RHN_PASSWORD/$RHN_PASSWORD/g" "$PARMS_FILE"
sed -i '' -e  "s/RHN_POOL_ID/$RHN_POOL_ID/g" "$PARMS_FILE"
sed -i '' -e  "s/AZURE_AD_NAME/$AZURE_AD_NAME/g" "$PARMS_FILE"
sed -i '' -e  "s/AZURE_AD_APP_ID/$AZURE_AD_APP_ID/g" "$PARMS_FILE"
sed -i '' -e  "s/AZURE_AD_SECRET/$AZURE_AD_SECRET/g" "$PARMS_FILE"

rm -f $SSH_KEYFILE
rm -f $SSH_KEYFILE.pub
ssh-keygen -N "" -f $SSH_KEYFILE
base64 -i $SSH_KEYFILE -o $SSH_KEYFILE.base64

SSH_PUBLIC_CONTENTS=$(<$SSH_KEYFILE.pub)
sed -i '' -e  "s|SSH_PUBLIC|$SSH_PUBLIC_CONTENTS|g" "$PARMS_FILE"

SSH_PRIVATE_BASE64_CONTENTS=$(<$SSH_KEYFILE.base64)
sed -i '' -e  "s|SSH_PRIVATE_BASE64|$SSH_PRIVATE_BASE64_CONTENTS|g" "$PARMS_FILE"

# az login
# az ad sp create-for-rbac -n $AZURE_AD_NAME -p $AZURE_AD_SECRET  --subscription "Pay-As-You-Go"

