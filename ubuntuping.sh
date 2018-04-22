#!/usr/bin/env bash
set -ex

create(){
	kubectl create -f ubuntuping.yaml
}

delete(){
	kubectl delete -f ubuntuping.yaml
}

$@