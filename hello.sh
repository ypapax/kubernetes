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
#	NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
#my-service   LoadBalancer   10.102.80.197   <pending>     8080:30507/TCP   38m
# EXTERNAL-IP is always pending, probably because it's not google cloud or AWS kubernetes, just deployed on local ubuntu machines
# https://stackoverflow.com/a/44112285/1024794

}

detailed(){
	kubectl describe services my-service
}

wide(){
	kubectl get pods --output=wide
}
$@