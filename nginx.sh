#!/usr/bin/env bash

create(){
	kubectl create deployment nginx --image=nginx
}

$@