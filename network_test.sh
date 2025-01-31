#!/bin/bash


target=$1
log=network.log



 || { cat $log; exit 1; }

if ping -c1 $target 2>> $log; then

	exit 0

