#!/bin/sh

if [ ! ${experiment_root} ]
then
    echo "experiment_root is unset in the shell"
    echo "please set experiment_root to point to your experiment directory"
    echo "see README for more information:"
    exit 2
fi

if test $# -ne 1
	then \
		echo Usage:
		echo install.sh comp_dir 
		echo comp_dir: orig
		exit 0
fi

subject_dir=${experiment_root}/airline
echo removing old files
rm -f -r ${subject_dir}/source/*
rm -f ${subject_dir}/outputs/*

if test $1 = "orig"
then
     echo copying files for orig version
     cp -r ${subject_dir}/versions.alt/orig/*.java ${subject_dir}/source 
else
     echo orig is the only option currently available
     exit 0
fi

cd ${subject_dir}/source

echo compiling application
echo "java home"
echo $JAVA_HOME
find . -name "*.java" | xargs javac -deprecation -source 1.4 > /dev/null

