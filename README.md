My notes and playing around with kubernetes.

## Installation
I used this resources:\
https://www.youtube.com/watch?v=6xJwQgDnMFE

https://blog.alexellis.io/kubernetes-in-10-minutes/


https://www.youtube.com/watch?v=b_fOIELGMDY

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
journalctl -u kubelet
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