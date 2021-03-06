#!/usr/bin/env bash
set -ex
guidip(){
	kubectl describe pods $(kubectl get pods | grep --color=never gui | awk '{print $1}') | grep IP | awk '{print $2}' # https://youtu.be/6xJwQgDnMFE?t=711
}

guidcurl(){
	curl $(guidip):9000/guid
}

expose(){
	kubectl expose deployment/guids
}

services(){
	kubectl get services
}

clusterip(){
	ip=$(kubectl get services | grep guids | awk '{print $3}')
	echo curl $ip:9000/guid
}

scale(){
	kubectl scale deployment/guids --replicas=3
}

po(){
	kubectl get po
}


deletePodByName(){
	podName=$1
	kubectl delete pods $podName --grace-period=0 --force
}

allowPodsOnMaster(){
	kubectl taint nodes --all node-role.kubernetes.io/master-
}

podssh(){
	podName=$1
	kubectl exec -ti $podName /bin/bash
}

$@