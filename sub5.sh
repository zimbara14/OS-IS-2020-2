#!/bin/bash

art=$(awk -F " : " -v pat="Parent_Process_ID=$1 :" '$0~pat {print $3}' fourth.out | awk -F '=' '{print $2}')
m=0
cnt=0
for a in $art
do
	m=$(bc<<<"scale=2;$m+$a")
	let cnt=$cnt+1
done
m=$(bc<<<"scale=2;$m/$cnt")
echo $m
