Sample setup that has issues with the openfaas gateway and queue-worker not starting on second startup.

After the box is started the first time by

```
vagrant up
```

everything is fine. However, after the box was stopped and started again by

```
vagrant halt
vagrant up
```

the OpenFaas gateway and queue-worker deployments most of the time do not start because of the error:

```
Can't connect: nats: no servers available for connection
```

The OpenFaas installation was tweaked by setting

```
kubectl -n openfaas set env deployment/gateway faas_nats_address=nats.openfaas.svc.cluster.local.
kubectl -n openfaas set env deployment/queue-worker faas_nats_address=nats.openfaas.svc.cluster.local.
```

in `provision-openfaas.sh`. Without the tweak the 2 mentioned deployments would not start even on the first startup.

The port of the Kubernetes dashboard can be forwarded to the host by running `forward-ports.sh` inside the virtual box. Afterwards the Kubernetes dashboard can be accessed at `http://localhost:5080`. Similarly, the OpenFaas gateway could be access at `http://localhost:5180` if the gateway deployment would start.  
