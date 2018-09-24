#!/bin/bash

# Get a list of users who have .plan / .project files in their home dir

# To run on a remote host use the command
# ssh user@host 'bash -s' < ./UserPlanProject.sh 

userList=$(getent passwd | cut -d : -f 1)
mkdir allUsers
mkdir allUsers/noPlanOrProject
mkdir allUsers/withPlanOrProject

for user in $(echo $userList)
do
    tmp=$(finger $user)
    if [[ $tmp == *"Plan:"* || $tmp == *"Project:"* || $tmp == *"Mail forwarded to"* ]]; then
        # User has plan, project or both :)
        printf "$tmp \n" >> allUsers/withPlanOrProject/$user.txt
    else
        printf "$tmp \n" >> allUsers/noPlanOrProject/$user.txt
    fi
done

