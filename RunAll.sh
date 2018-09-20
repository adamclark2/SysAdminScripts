#!/bin/bash

# Run a command on a series of hosts via ssh
# $1 the username
# $2 the command

hosts=( "ant.cs.usm.maine.edu" 
        "beetle.cs.usm.maine.edu" 
        "firefly.cs.usm.maine.edu"
        "honeybee.cs.usm.maine.edu"
        "locust.cs.usm.maine.edu"
        "mosquito.cs.usm.maine.edu"
        "wasp.cs.usm.maine.edu"
);
outputFile="output.txt"

for host in ${hosts[*]}
do
    echo $1@$host >> $outputFile
    echo --------------------------------------------- >> $outputFile

    ssh $1@$host $2 >> $outputFile

    echo >> $outputFile
    echo >> $outputFile
done