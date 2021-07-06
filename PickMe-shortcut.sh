#!/bin/bash

PATH="/home/julien/Bureau/JOE/PickMe-main"

SCRIPT=${1-PickMe.sh}
INPUTFILE=${2?Error: no inputfile provided}
OPTION=${3-A}

PATH2=$(pwd)

cd "$PATH"

echo 'start'

export PATH=/usr/bin/:$PATH

if [ $SCRIPT == "PickMe.sh" ]
	then
		./$SCRIPT $PATH2/$INPUTFILE
	fi
if [ $SCRIPT == "PickMe_FR.sh" ]
	then
		./$SCRIPT $PATH2/$INPUTFILE
	fi
if [ $SCRIPT == "PickMeQ.sh" ]
	then
		./$SCRIPT $PATH2/$INPUTFILE $OPTION
	fi
if [ $SCRIPT == "PickMeQ_FR.sh" ]
	then
		./$SCRIPT $PATH2/$INPUTFILE $OPTION
	fi
		
cd "$PATH2"
