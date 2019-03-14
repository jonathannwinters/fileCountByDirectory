#!/bin/bash

############################################################################
# Title: fileCountByDirectory.sh                                                   
#                                                                          
# Description: A linux shell script that recursively goes through every    
# directory and finds the file+dir count. Then sorts descending by count. 
# Results are written to a file in the current directory called 
# SortedCountFile.csv                                   
#                                                               
# Author: Jonathan N. Winters, jnw25@cornell.edu                           
# Date:   March 14, 2019
# Version: 0.2
#
############################################################################



# EndUser Can Set These Variables
Path="/Users/jonathannwinters/Public/";
MaxDepth=10;



#backup current IFS variable
OIFS=$IFS;
IFS=",";

#create CSV string of all directories starting in current directory
dirs=$(find $Path -maxdepth $MaxDepth -type d | while read dir; do echo $dir"," | tr -d '\r' | tr -d '\n';  done) 

#convert this string into an array
dirArray=($dirs);

# Intialize and clear any existing temp file and Sorted output file
touch TempCountFile.csv ;
rm TempCountFile.csv;
touch TempCountFile.csv;
touch SortedCountFile.csv ;
rm SortedCountFile.csv;
touch SortedCountFile.csv;

#loop through the array and get the file+dir counts in each directory
for ((i=0; i<${#dirArray[@]}; ++i));  do    
        dirName="${dirArray[$i]}"; 
        count=`(ls ${dirArray[$i]}  | wc -l) | awk '{$1=$1};1'`;
        echo -e "$count, $dirName" >> TempCountFile.csv;
done

# sort and output the TempFile
sort -k1 -n -r TempCountFile.csv >> SortedCountFile.csv ; 
#rm TempCountFile.csv;
#rm SortedCountFile.csv;

#reset the IFS variable back to before running this script
IFS=$OIFS;


