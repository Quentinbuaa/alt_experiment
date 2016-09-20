#!/bin/bash

CGROUP_AIRLINE=/sys/fs/cgroup/memory/airline
AIRLINE_HOME=/home/quentin/workspace/airline
SCRIPTS_PATH=$AIRLINE_HOME/scripts

#$1 is use to set memory.limit_in_bytes
set_test_env(){
		cd $AIRLINE_HOME/scripts
		sudo ./cgroup_set.sh $1
}


cgexec_airline(){
	
		cd $AIRLINE_HOME/scripts
		echo "executing airline"
		sudo cgexec -g memory:airline ./run.sh
}


# monitor the number of times that the memory limit has reached the vaule set in memory.limit_in_bytes and maximum usage in bytes
# $1 is used to identify the memory hit
monitor(){

		echo $1 >> $AIRLINE_HOME/data/hit_time.log
		cd $CGROUP_AIRLINE
		cat memory.failcnt | tee -a $AIRLINE_HOME/data/hit_time.log 
		cat memory.max_usage_in_bytes | tee -a $AIRLINE_HOME/data/hit_time.log 
}

main(){
		#test initialization
		if [ ! -d $AIRLINE_HOME/data ];then
				mkdir $AIRLINE_HOME/data
		fi

		#test memory setup
		cd $AIRLINE_HOME/scripts
		mem_lim=200M
		set_test_env $mem_lim

		#test execution

		for i in $(seq 10): 
		do
				# execute airline
			cgexec_airline
			monitor $mem_lim
			sleep 3
		done
}

main
		
