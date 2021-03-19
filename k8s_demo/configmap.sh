#!/bin/bash

kubectl delete configmap -n yaopengming nginx-vh-config
kubectl create configmap -n yaopengming nginx-vh-config --from-file=configmap/nginx/default.conf
