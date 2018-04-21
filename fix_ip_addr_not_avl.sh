#!/usr/bin/env bash
PS4='+(${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): } $HOSTNAME $ '
set -ex
# https://github.com/kubernetes/kubernetes/issues/57280#issuecomment-356431256

kubeadm reset
systemctl stop kubelet
systemctl stop docker
rm -rf /var/lib/cni/
rm -rf /var/lib/kubelet/*
rm -rf /etc/cni/
set +e
ifconfig cni0 down
ifconfig flannel.1 down
ifconfig docker0 down
ip link delete cni0
ip link delete flannel.1
set -e
>&2 echo now reboot this machine and run kubeadm join again