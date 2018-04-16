#!/usr/bin/env bash
set -ex
# https://kubernetes.io/docs/tutorials/stateless-application/expose-external-ip-address/

run(){

	kubectl run hello-world --replicas=5 --labels="run=load-balancer-example" --image=gcr.io/google-samples/node-hello:1.0  --port=8080
}

get(){
	kubectl get deployments hello-world
}

describe(){
	kubectl describe deployments hello-world
}

expose(){
	kubectl expose deployment hello-world --type=LoadBalancer --name=my-service
}

display(){
	kubectl get services my-service
}

detailed(){
	kubectl describe services my-service
}

wide(){
	kubectl get pods --output=wide
}
$@