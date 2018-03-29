#!/bin/bash

# By Adam
# March 28th 2018
# Input an apache tomcat log and convert to csv
# csv files can be opened in excel for analysis

echo "IP Address,  Blank1, Blank 2, Time, Endpoint, Status Code, Number?"

for i in $@
do
    while read -r line; do
        isPrintingLast=0
        for word in $line; do
            if [ "$(printf $word | grep \" | wc -l)" -gt "0" ] || [ "$(printf $word | grep '\[' | wc -l)" -gt "0" ] || [ "$(printf $word | grep '\]' | wc -l)" -gt "0" ]
            then
                if [ $isPrintingLast -eq 1 ]
                then
                    isPrintingLast=0
                else
                    isPrintingLast=1
                fi
            fi

            if [ $isPrintingLast -eq 1 ]
            then
                printf "%s" $word
            else
                printf "%s, " $word 
            fi
        done
        isPrintingLast=0
        printf "\n"
    done <<< "$(cat $i)"
done

