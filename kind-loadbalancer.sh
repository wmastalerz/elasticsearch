#!/bin/bash
kubectl apply -f metallb-native.yaml
kubectl wait --namespace metallb-system \
                --for=condition=ready pod \
                --selector=app=metallb \
                --timeout=90s

ippool=$(docker network inspect -f '{{.IPAM.Config}}' kind)
ipprefix="${ippool:2:7}"
metalb=$(cat metallb-config.yaml)
echo "${metalb//172.19./$ipprefix}" | kubectl apply -f -


