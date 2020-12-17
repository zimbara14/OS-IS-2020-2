#!/bin/bash

echo >> temp

top -b -o VIRT -n 1 | sed -n '/PID/,$p' | sed -n '2p' | awk '{printf "%s %s\n", $1, $5}'
for p in /proc/*
do
	if [[ $p =~ /proc/[0-9]+ ]]; then
		awk -v p=$p '/VmSize/ {printf "%s %s\n", p, $2}' "$p/status" >> temp
	fi
done

sort -n -k 2 temp | tail -n 1
rm temp

#top -b -o VIRT | head -n 8 | tail -n 2 | awk '{printf "%s %s\n",$1,$5}'
