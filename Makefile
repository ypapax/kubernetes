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
delete:
	kubectl delete --kubeconfig ./config  -f todo-all-in-one.yaml
svc:
	kubectl --kubeconfig ./config get svc
redeploytodo:
	kubectl --kubeconfig ./config replace  --force -f todo-all-in-one.yaml
#redeploytodo:
#	envsubst < todo-all-in-one.yaml | /tmp/todo-all-in-one.yaml && kubectl apply --force -f /tmp/todo-all-in-one.yaml # attempt to use env var inside yaml
deployments:
	 kubectl --kubeconfig config get deployments