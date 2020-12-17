#!/bin/bash

ps aux | awk '$1 == "user"{print $0}' > temp
cat temp | wc -l > first.out
awk '{printf "%s:%s\n", $2, $11}' temp >> first.out
rm temp
