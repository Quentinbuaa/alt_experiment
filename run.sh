#!/bin/bash

export AIRLINE_HOME=/home/quentin/workspace/airline
source /etc/profile

execute_bug_program(){
		java Main 10000 3
}

cd $AIRLINE_HOME/source 
execute_bug_program
