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
