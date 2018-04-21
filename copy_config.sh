#!/usr/bin/env bash
set -ex
if [ -z "$IP" ] || [ -z "$USR" ]; then
	set +ex
	>&2 echo usage:
	>&2 echo USR=user IP=1.2.3.4 $0
	exit 1
fi
scp ${USR}@${IP}:'$HOME'/.kube/config .
cp ~/.kube/config ~/.kube/config.bak && cp config ~/.kube
kubectl get nodes

