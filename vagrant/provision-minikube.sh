#!/bin/sh
# cf. https://github.com/kubernetes/minikube

echo fetch and install minikube...
curl -Lso minikube https://storage.googleapis.com/minikube/releases/v0.31.0/minikube-linux-amd64 && chmod +x minikube && sudo cp minikube /usr/local/bin/ && rm minikube

# minikube needs socat for port forwarding when using the --vm-driver=none
apt-get install socat

echo start minikube...
minikube start --vm-driver=none --extra-config=kubelet.resolv-conf=/run/systemd/resolve/resolv.conf
echo minikube started

# this for loop waits until kubectl can access the api server that Minikube has created
for i in {1..150}; do # timeout for 5 minutes
   kubectl get po &> /dev/null
   if [ $? -ne 1 ]; then
      break
  fi
  sleep 2
done

chown -R vagrant.vagrant $VAGRANT_USER_HOME/.kube
chown -R vagrant.vagrant $VAGRANT_USER_HOME/.minikube
