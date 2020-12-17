#!/bin/bash

for pid in /proc/*
do
	if [[ $pid =~ /proc/[0-9]+ ]]; then
		ppid=$(awk '/PPid/ {print $2}' "$pid/status")
		s=$(awk '/sum_exec_runtime/ {print $3}' "$pid/sched")
		n=$(awk '/nr_switches/ {print $3}' "$pid/sched")
		art=$(bc<<<"scale=2;$s/$n")
		IFS='/' read -ra arr <<< "$pid"
		pid=${arr[2]}
		printf "ProcessID=%s : Parent_Process_ID=%s : Average_Running_Time=%f\n" $pid $ppid $art >> temp
	fi
done

sort -k 3 -V temp > fourth.out
rm temp
