My notes and playing around with kubernetes.

## Installation
I used this resources:\
https://www.youtube.com/watch?v=6xJwQgDnMFE

https://blog.alexellis.io/kubernetes-in-10-minutes/


https://www.youtube.com/watch?v=b_fOIELGMDY

### Installing [dependencies](https://blog.alexellis.io/kubernetes-in-10-minutes/)
```
curl -sL https://gist.githubusercontent.com/alexellis/7315e75635623667c32199368aa11e95/raw/b025dfb91b43ea9309ce6ed67e24790ba65d7b67/kube.sh | sudo sh
```

## Issues
### unable to get nodes
Had error
```
sudo kubectl get nodes
```
Unable to connect to the server: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "kubernetes")


this helped: https://github.com/kubernetes/kubernetes/issues/48378#issuecomment-374412266

### master node is always not ready
```
$ sudo kubectl get nodes
NAME      STATUS     ROLES     AGE       VERSION
b         NotReady   master    10m       v1.10.0
```
checking [logs](https://stackoverflow.com/a/44652403/1024794):
```
journalctl -xn -u kubelet | less
```
and see:
```
Apr 03 16:19:16 b kubelet[5139]: W0403 16:19:16.632684    5139 cni.go:171] Unable to update cni config: No networks found in /etc/cni/net.d
Apr 03 16:19:16 b kubelet[5139]: E0403 16:19:16.633059    5139 kubelet.go:2125] Container runtime network not ready: NetworkReady=false reason:NetworkPluginNotReady message:dock
```

Tried to [remove](https://github.com/kubernetes/kubernetes/issues/43815#issuecomment-290235245)  $KUBELET_NETWORK_ARGS from file /etc/systemd/system/kubelet.service.d/10-kubeadm.conf.
It didn't help.

Here is [default](https://github.com/kubernetes/release/blob/master/debian/xenial/kubeadm/channel/stable/etc/systemd/system/kubelet.service.d/post-1.8/10-kubeadm.conf) for backup.
```
$ sudo kubectl get all --all-namespaces
```

```
NAMESPACE     NAME                        READY     STATUS    RESTARTS   AGE
kube-system   etcd-b                      1/1       Running   0          1m
kube-system   kube-apiserver-b            1/1       Running   0          1m
kube-system   kube-controller-manager-b   1/1       Running   0          1m
kube-system   kube-dns-86f4d74b45-x2nf4   0/3       Pending   0          2m
kube-system   kube-proxy-ttjqd            1/1       Running   0          2m
kube-system   kube-scheduler-b            1/1       Running   0          1m

NAMESPACE     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)         AGE
default       kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP         2m
kube-system   kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP   2m

NAMESPACE     NAME         DESIRED   CURRENT   READY     UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   kube-proxy   1         1         1         1            1           <none>          2m

NAMESPACE     NAME       DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
kube-system   kube-dns   1         1         1            0           2m

NAMESPACE     NAME                  DESIRED   CURRENT   READY     AGE
kube-system   kube-dns-86f4d74b45   1         1         0         2m
```
it has kube dns pending:
```
kube-system   kube-dns-86f4d74b45-x2nf4   0/3       Pending   0          4m
```

This `Not ready` status is [solved](https://stackoverflow.com/a/44113181/1024794) by setting a Network Overlay:
```
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml 
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
```

### Status is not running for several pods:
```
kubectl get pods --all-namespaces
NAMESPACE     NAME                          READY     STATUS              RESTARTS   AGE
kube-system   etcd-np3                      1/1       Running             0          10h
kube-system   kube-apiserver-np3            1/1       Running             0          10h
kube-system   kube-controller-manager-np3   1/1       Running             0          10h
kube-system   kube-dns-86f4d74b45-xc9f8     0/3       ContainerCreating   0          10h
kube-system   kube-flannel-ds-j9vdm         0/1       CrashLoopBackOff    42         9h
kube-system   kube-flannel-ds-nclm7         0/1       CrashLoopBackOff    54         10h
kube-system   kube-flannel-ds-t5qjh         0/1       CrashLoopBackOff    47         10h
kube-system   kube-proxy-4z466              1/1       Running             0          10h
kube-system   kube-proxy-8rccx              1/1       Running             2          10h
kube-system   kube-proxy-hqtzs              1/1       Running             0          9h
kube-system   kube-scheduler-np3            1/1       Running             0          10h
```
ContainerCreating and CrashLoopBackOff:

```
kube-system   kube-dns-86f4d74b45-xc9f8     0/3       ContainerCreating   0          10h
kube-system   kube-flannel-ds-j9vdm         0/1       CrashLoopBackOff    42         9h
kube-system   kube-flannel-ds-nclm7         0/1       CrashLoopBackOff    54         10h
kube-system   kube-flannel-ds-t5qjh         0/1       CrashLoopBackOff    47         10h
```
Let's [debug](https://serverfault.com/a/730746/157584) it:
```
 kubectl describe pods
 ```
 shows nothing.
```
kubectl describe po kube-dns-86f4d74b45-xc9f8
```
Gives:
	Error from server (NotFound): pods "kube-dns-86f4d74b45-xc9f8" not found
	
