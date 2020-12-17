#!/bin/bash

ps -Ao pid,start | sort -n $2 | tail -n 1

