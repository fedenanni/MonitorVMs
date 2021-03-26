#!/usr/bin/env bash

OUTPUT=$(az vm list --subscription b8871872-a5e3-473f-b9b9-f4baaab6a9a0 -d -o tsv --query "[?powerState=='VM running'].{resource:resourceGroup, name:name}")

IFS=$'\n' read -ra VMS -d $'\0' <<< "$OUTPUT"

RES=()

for VM in "${VMS[@]}"
do
    IFS=$'\t' read -ra RES -d $'\0' <<< "$VM"

    RUN=$(az vm monitor metrics tail --subscription b8871872-a5e3-473f-b9b9-f4baaab6a9a0 --name ${RES[1]} --resource-group ${RES[0]} --metric "Percentage CPU")
    # store the results somewhere
    echo "${RUN}"

done