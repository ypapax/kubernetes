#!/usr/bin/env bash
set -ex
sudo kubeadm reset
sudo rm -rf $HOME/.kube # https://github.com/kubernetes/kubernetes/issues/48378#issuecomment-374412266

sudo kubeadm init | tee /tmp/join

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubectl get nodes

sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
#sudo kubectl apply -f https://github.com/kubernetes/dashboard/blob/master/src/deploy/recommended/kubernetes-dashboard.yaml

sudo watch kubectl get nodes