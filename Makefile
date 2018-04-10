master:
	sudo kubeadm init --pod-network-cidr=255.255.255.0/24 --apiserver-advertise-address=192.168.0.101
dashboard:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
proxy:
	kubectl proxy --address=0.0.0.0 --accept-hosts='.*'
pods:
	kubectl get pods
ip:
	kubectl describe pod | grep IP:
curl:
	curl http://${ip}:9000/guid ; echo # ip parameter should be exported
tokens:
	kubectl -n kube-system get secret #https://github.com/kubernetes/dashboard/wiki/Access-control
token:
	kubectl -n kube-system describe secret ${token_name}
# another way of getting token: https://github.com/kubernetes/dashboard/issues/2474#issuecomment-348811806

nodes:
	kubectl get nodes
allpods:
	kubectl get pods --all-namespaces
log:
	journalctl -xn -u kubelet | less