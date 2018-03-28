https://www.youtube.com/watch?v=6xJwQgDnMFE

https://blog.alexellis.io/kubernetes-in-10-minutes/


Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join 192.168.0.101:6443 --token r0gjto.m9d1saxrmwe00hal --discovery-token-ca-cert-hash sha256:9b8360a144384c896498a57a5f27926bdd747d35a8ac3b4331e6d9f0c7fb1613