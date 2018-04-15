#!/usr/bin/env bash
set -ex
guidip(){
	kubectl describe pods $(kubectl get pods | grep --color=never gui | awk '{print $1}') | grep IP | awk '{print $2}' # https://youtu.be/6xJwQgDnMFE?t=711
}

guidcurl(){
	curl $(guidip):9000/guid
}

$@