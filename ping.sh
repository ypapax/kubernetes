#!/usr/bin/env bash
set -ex

create(){
	kubectl create -f ping.yaml
}

delete(){
	kubectl delete -f ping.yaml
}

$@