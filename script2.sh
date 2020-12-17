#!/bin/bash

ps -Ao pid,command | grep -E " *[0-9]+ /sbin/" > second.out
