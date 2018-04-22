#!/usr/bin/env bash
set -ex

#https://youtu.be/kT1vmK0r184?t=1748
run(){
	kubectl run badserver --image=ubuntu:16.04 -l visualize=true,run=badserver
}

bad2(){
	kubectl run badserver2 --image=ubuntu -l visualize=true,run=badserver2
}

bad3(){
	kubectl run badserver3 --image=teran/ubuntu-network-troubleshooting -l visualize=true,run=badserver3
}

nginx2(){
	kubectl run nginx2 --image=nginx -l visualize=true,run=nginx2
}

docker_ubuntu(){
	docker run -it ubuntu
}



$@