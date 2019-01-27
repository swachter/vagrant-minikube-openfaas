#!/bin/sh

echo install registry...
kubectl apply -f kube-registry.yaml
registryPod=$(kubectl get po -n kube-system | grep kube-registry-v0 | awk '{print $1;}')
echo wait for registry...
kubectl wait --timeout=120s --namespace kube-system --for=condition=Ready pod/$registryPod
echo registry ready
