#!/bin/bash

export TST_ROOT=/home/quentin/workspace/airline
export TST_SCRIPT=$TST_ROOT/scripts/concurrent_level

#P percentage of CPU that this job got. This is just the user+system times divide by the total running time.


#%R minor page fault,\t%M Max_Rss,\t%P CPU per
execute_bug_program(){
		/usr/bin/time -f "%R\t%M\t%P" -o $TST_SCRIPT/env.log -a java Main $1 $2 	
		#data_dispose.py
}

test(){
for first in 1000
	do
			for second in 3
			do
					for i in $(seq 20)
					do execute_bug_program $first $second
					done

			done
	done
}
main(){
	for first in 1000 4000 7000 10000 13000 16000 19000 22000
	do
			for second in 3 10 50 100 200 600
			do
					for i in $(seq 20)
					do
						execute_bug_program $first $second
					done

			done
	done
}

cd $TST_ROOT/source 
test
