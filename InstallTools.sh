#!/bin/bash

# By Adam
# March 30th 2018
# Install tools

sudo apt-get update
sudo apt-get install lynis, inode-tools, docker.io, nmap, lsof

# linys audit system => Perform a basic security audit and get hints how to fix them
# docker.io => required to run docker 
# inode-tools => inotifywait /dir --recursive --monitor => monitor a dir for changes (logging)
# nmap => port scanner/service discovery
# lsof => check to see which programs are using which ports