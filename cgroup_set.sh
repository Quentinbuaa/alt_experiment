#!/bin/bash

clean_up(){
		umount mnt 2> /dev/null
		if [ $? -ne 0 ]; then
				echo "unmount fail"
				exit 1
		fi
		rmdir mnt
}

do_cpu_mount(){
		if [ -d mnt ];then 
				clean_up
		fi
		mkdir mnt
		mount -t cgroup -o cpu cgroup mnt
		if [ $? -ne 0 ];then
				echo "fail to mount cgroup/memory"
				rmdir mnt
				exit 1
		fi

		cd mnt
		if [ -d airline ]; then
				rmdir airline
		fi
		mkdir airline
		cd airline
}
do_memory_mount(){
		if [ -d mnt ];then 
				clean_up
		fi
		mkdir mnt
		mount -t cgroup -o memory cgroup mnt
		if [ $? -ne 0 ];then
				echo "fail to mount cgroup/memory"
				rmdir mnt
				exit 1
		fi

		cd mnt
		if [ -d airline ]; then
				rmdir airline
		fi
		mkdir airline
		cd airline
}


main(){
do_mount
mem_lim=$1
echo $mem_lim > memory.limit_in_bytes
}
main $1



