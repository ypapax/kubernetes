dashboard:
	kubectl --kubeconfig ./config apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
proxy:
	kubectl --kubeconfig ./config proxy --address=0.0.0.0 --accept-hosts='.*'
pods:
	kubectl --kubeconfig ./config get pods
ip:
	kubectl --kubeconfig ./config describe pod | grep IP:
curl:
	curl http://${ip}:9000/guid ; echo # ip parameter should be exported
tokens:
	kubectl --kubeconfig ./config -n kube-system get secret #https://github.com/kubernetes/dashboard/wiki/Access-control
token:
	kubectl --kubeconfig ./config -n kube-system describe secret ${token_name}
# another way of getting token: https://github.com/kubernetes/dashboard/issues/2474#issuecomment-348811806

nodes:
	kubectl --kubeconfig ./config get nodes
allpods:
	watch kubectl --kubeconfig ./config get pods --all-namespaces
log:
	journalctl -xn -u kubelet | less
getconf:
	scp ${USER}@${IP}:'$$HOME'/.kube/config .