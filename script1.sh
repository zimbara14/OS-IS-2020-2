#!/bin/bash

#ps -U user -o pid,command | tail -n +2 | sed -r "s/\s*([0-9]+)\s(.+)$/\1:\2/" > answer.txt

#ps -Admin o pid,user,command

ps a -u admin --format pid,command | awk '{print $1":"$2}'
