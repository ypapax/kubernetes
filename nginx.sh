#!/usr/bin/env bash
set -ex

# https://linode.com/docs/applications/containers/how-to-deploy-nginx-on-a-kubernetes-cluster/#deploy-nginx-on-the-kubernetes-cluster
create(){
	kubectl create deployment nginx --image=nginx
}

get(){
	kubectl get deployments
}

describe(){
	kubectl describe deployment nginx
}

createSvc(){
	kubectl create service nodeport nginx --tcp=80:80
}

svc(){
	kubectl get svc
}

delete(){
	kubectl delete deployment nginx
}

$@