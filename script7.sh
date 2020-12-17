#!/bin/bash

for i in 1 2
do
	for pid in /proc/*
	do
		if [ -r "$pid/io" ]; then
			if [[ $pid =~ /proc/[0-9]+ ]]; then
				if [[ $i == "1" ]]; then
					awk -v pid=$pid '/read_bytes/ {printf "%s %s\n", pid, $2}' "$pid/io" >> temp1
				fi
				if [[ $i == "2" ]]; then
					curr=$(awk '/read_bytes/ {printf "%s", $2}' "$pid/io")
					prevv=$(awk -v pid="$pid " '$0~pid {printf "%s", $2}' temp1)
					read_bytes=$(( curr - prevv ))
					printf "%s %s\n" $pid $read_bytes >> temp2
				fi
			fi
		fi
	done
	if [[ $i == "1" ]]; then
		sleep 60
	fi
done

sort -r -n -k 2 temp2 | head -n 3
rm temp1
rm temp2
