#!/usr/bin/env bash
for res in $( az vm list --subscription b8871872-a5e3-473f-b9b9-f4baaab6a9a0 -d -o json --query "[?powerState=='VM running'].{resource:resourceGroup, name:name}"); do
    echo $res
done