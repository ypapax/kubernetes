pods:
	kubectl --kubeconfig ./config get pods
nodes:
	kubectl --kubeconfig ./config get nodes
allpods:
	watch kubectl --kubeconfig ./config get pods --all-namespaces
log:
	journalctl -xn -u kubelet | less
getconf:
	scp ${USER}@${IP}:'$$HOME'/.kube/config .
deploytodo:
	kubectl --kubeconfig ./config create  -f todo-all-in-one.yaml
svc:
	kubectl --kubeconfig ./config get svc