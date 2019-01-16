Sample setup for Vagrant / VirtualBox / Minikube / Docker / OpenFaaS
-

The OpenFaaS pods may take a long time (tens of minutes) to reach the "Running" status, in particular after a restart of the box.

The OpenFaas installation was tweaked by setting

```
kubectl -n openfaas set env deployment/gateway faas_nats_address=nats.openfaas.svc.cluster.local.
kubectl -n openfaas set env deployment/queue-worker faas_nats_address=nats.openfaas.svc.cluster.local.
```

in `provision-openfaas.sh`. Without the tweak the gateway and queue-worker deployments do not start.

The port of the Kubernetes dashboard can be forwarded to the host by running `forward-ports.sh` inside the virtual box. Afterwards the Kubernetes dashboard can be accessed on the host at `http://localhost:5080`. Similarly, the OpenFaas gateway can be access at `http://localhost:5180`.  
