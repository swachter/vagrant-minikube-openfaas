#!/bin/sh

export OPENFAAS_GW=$(minikube ip):31112
export OPENFAAS_GW_PW=pw1234
export OPENFAAS_REGISTRY=localhost:5000

# install OpenFaas

echo apply openfaas namespaces...
kubectl apply -f https://raw.githubusercontent.com/openfaas/faas-netes/master/namespaces.yml

echo add openfaas repo...
helm repo add openfaas https://openfaas.github.io/faas-netes/
helm repo update

echo create openfaas secret...
kubectl -n openfaas create secret generic basic-auth --from-literal=basic-auth-user=admin --from-literal=basic-auth-password="$OPENFAAS_GW_PW"

echo upgrade openfaas...
helm upgrade openfaas --install openfaas/openfaas --namespace openfaas --set functionNamespace=openfaas-fn --set basic_auth=true
echo openfaas upgraded

faas_cli_version=0.7.8
echo "fetch and install faas-cli (version $faas_cli_version)"
wget -q -O /usr/local/bin/faas-cli https://github.com/openfaas/faas-cli/releases/download/${faas_cli_version}/faas-cli && chmod +x /usr/local/bin/faas-cli
echo faas-cli installed

# fix faas_nats_address (cf. https://github.com/openfaas/faas-netes/issues/351)
kubectl -n openfaas set env deployment/gateway faas_nats_address=nats.openfaas.svc.cluster.local.
kubectl -n openfaas set env deployment/queue-worker faas_nats_address=nats.openfaas.svc.cluster.local.

# To verify that openfaas has started run
# kubectl --namespace=openfaas get deployments -l "release=openfaas, app=openfaas"