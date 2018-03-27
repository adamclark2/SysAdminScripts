#!/bin/bash

# By Adam
# March 27th 2018
# A basic script to count the number of differences in docker diff
# for all containers on the host

criticalAreas=("bin" "sbin" "www" "webapps" "etc" "conf" "config" "json" "xml")

host=$(hostname)
hostIp=$(hostname -I) 

echo ""
echo "Hostname: " $host
echo "Host IP(s): " $hostIp

printf "Critical Areas: "
for area in "${criticalAreas[@]}"
do
    printf "$area "
done
echo ""

printf "|%21s|%20s|%20s|%20s|\n" "Docker Container Name" "Image Name" "Differences" "Critical"
echo "--------------------------------------------------------------------------------------"

dockerIds=$( docker ps -a --format="{{.ID}}" )
count=$( docker ps -a --format="{{.ID}}" | wc -l)
dockerDiffs=" "

for i in $(seq 1 1 $count)
do
    dockerId=$( echo $dockerIds | awk '{print $'$i'}' )
    dockerDiff=$( docker diff $dockerId )
    
    imageName=$(docker ps -a -f id=$dockerId --format="{{.Image}}")
    containerName=$(docker ps -a -f id=$dockerId --format="{{.Names}}")

    dockerDiffs+="\n\n\n$containerName\tImage: $imageName\n"
    dockerDiffs+=$dockerDiff

    isCritical="NO"

    for area in "${criticalAreas[@]}"
    do
        if [ "$(printf "$dockerDiff" | grep -i $area | wc -l)" -gt "0" ]
        then
            isCritical="YES"
        fi
    done

    # Printout to console
    printf "|%21s|%20s|%20s|%20s|\n" $containerName $imageName $(printf "$dockerDiff" | wc -l) $isCritical
done 

printf "$dockerDiffs"