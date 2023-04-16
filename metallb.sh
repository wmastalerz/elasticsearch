#!/bin/bash
kubectl apply -f metallb-native.yaml
kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s
ippool=$(docker network inspect -f '{{.IPAM.Config}}' kind |awk {'print substr($2,1,7)'})

