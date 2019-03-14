#!/bin/bash
#!!!!!!!!!!!!!!!!!!!!!! WORK IN PROGRESS DO NOT USE !!!!!!!!!!!!!!!!!!!!!!!

############################################################################
# Title: fileCountByDirectory.sh                                                   
#                                                                          
# Description: A linux shell script that recursively goes through every    
# directory and finds the file+dir count. Then sorts descending by count.                                    
#                                                               
# Author: Jonathan N. Winters, jnw25@cornell.edu                           
# Date:   March 13, 2019
# Version: 0.1
#
############################################################################

#backup current IFS variable
OIFS=$IFS;
IFS=",";

#create CSV string of all directories starting in current directory
dirs=$(find . -maxdepth 2 -type d | while read dir; do echo $dir"," | cut -c 3- | tr -d '\r' | tr -d '\n';  done) 

#convert this string into an array
dirArray=($dirs);

#loop through the array and get the file+dir counts in each directory
for ((i=0; i<${#dirArray[@]}; ++i));  do    
        dirName="${dirArray[$i]}"; 
        count=`(ls ${dirArray[$i]}  | wc -l) | awk '{$1=$1};1'`;
        echo -e "$count : $dirName"  ;
        #POTENTIAL WORK IN PROGRESS sort -n -t: -k 1         | sort -n -t: -k 1

done





#reset the IFS variable back to before running this script
IFS=$OIFS;


