#!/usr/bin/env bash
set -ex

#https://youtu.be/kT1vmK0r184?t=1748
run(){
	kubectl run badserver --image=ubuntu:16.04 -l visualize=true,run=badserver
}

$@