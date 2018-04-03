#!/usr/bin/env bash
set -ex
sudo kubeadm reset
sudo rm -rf $HOME/.kube # https://github.com/kubernetes/kubernetes/issues/48378#issuecomment-374412266

sudo kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

sudo kubectl get nodes