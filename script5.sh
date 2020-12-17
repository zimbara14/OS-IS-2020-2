#!/bin/bash

ppid=$(awk -F " : " '{print $2}' fourth.out | uniq | awk -F '=' '{print $2}')
for p in $ppid
do
	m=$(./sub5.sh $p)
	l="Average_Sleeping_Children_of_Parent_ID=$p is $m"
	last=$(awk -v pat="Parent_Process_ID=$p" '$0~pat {print NR}' fourth.out | tail -n 1)
	old=$(sed "${last}q;d" fourth.out)
	sed "${last}s/$old/$old\n$l\n/" fourth.out > newF
	cat newF > fourth.out
done
rm newF

