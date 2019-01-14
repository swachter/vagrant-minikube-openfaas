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

the OpenFaas gateway and queue-worker do sometime not start because of the error:

```
Can't connect: nats: no servers available for connection
```

The OpenFaas installation was tweaked by setting

```
kubectl -n openfaas set env deployment/gateway faas_nats_address=nats.openfaas.svc.cluster.local.
kubectl -n openfaas set env deployment/queue-worker faas_nats_address=nats.openfaas.svc.cluster.local.
```

in `provision-openfaas.sh`. Without the deployment would not start even on the first startup.
