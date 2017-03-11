#!/bin/bash

# test the hadoop cluster by running wordcount

# create input files 
#mkdir input
#echo "Hadoop MapReduce Counter provides a way to measure the progress or the number of operations that occur within MapReduce programs Basically MapReduce framework provides a number of built-in counters to measure basic I/O operations such as FILE_BYTES_READ/WRITTEN and Map/Combine/Reduce input/output records These counters are very useful especially when you evaluate some MapReduce programs Besides the MapReduce Counter allows users to employ your own counters Since MapReduce Counters are automatically aggregated over Map and Reduce phases it is one of the easiest way to investigate internal behaviors of MapReduce programs In this post I’m going to introduce how to use your own MapReduce Counter The example sources described in this post are based on Hadoop 0.21 API" >input/file2.txt
#echo "Hello Hadoop" >input/file1.txt

# create input directory on HDFS
hadoop fs -mkdir -p input

# put input files to HDFS
hdfs dfs -put ./input/* input

# run wordcount 
hadoop jar hadp.jar BigramCount input output

#print the input files
echo -e "\ninput file content: "
hdfs dfs -cat input/file.txt

#echo -e "\ninput file2.txt:"
#hdfs dfs -cat input/file2.txt

# print the output of wordcount
echo -e "\nbigram count output:"
hdfs dfs -cat output/part-r-00000 > out.txt

# process the output
java -cp hadp.jar PostProc out.txt