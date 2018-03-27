#!/bin/bash

# By Adam
# March 27 2018
# A basic script to get the failed passwords from /var/log/auth.log and
# put them in a readable format
echo "Login Attempts with Failed Passwords:" > $1
echo "cat /var/log/auth.log | grep \"Failed password\" >> $1" >> $1
echo "" >> $1
cat /var/log/auth.log | grep "Failed password" >> $1