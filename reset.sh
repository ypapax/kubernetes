#!/usr/bin/env bash
set -ex
cleanup(){
	if [ $? -eq 0 ]; then
		echo SUCCESS
	else
		echo FAILED
	fi
}
trap cleanup EXIT
sudo kubeadm reset
sudo rm -rf $HOME/.kube # https://github.com/kubernetes/kubernetes/issues/48378#issuecomment-374412266

sudo kubeadm init | tee /tmp/join

sudo su packet << EOF
	set -ex
	cd $HOME
	sudo whoami


	sudo cp /etc/kubernetes/admin.conf $HOME/
	sudo chown $(id -u):$(id -g) $HOME/admin.conf
	export KUBECONFIG=$HOME/admin.conf
	echo "export KUBECONFIG=$HOME/admin.conf" | tee -a ~/.bashrc


	sudo kubectl get nodes

	sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
	sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml

	sudo watch kubectl get nodes
EOF