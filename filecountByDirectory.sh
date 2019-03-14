#!/bin/bash

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




# EndUser Can Set These Variables
Path=".";
MaxDepth=10;


#backup current IFS variable
OIFS=$IFS;
IFS=",";




#create CSV string of all directories starting in current directory
dirs=$(find $Path -maxdepth $MaxDepth -type d | while read dir; do echo $dir"," | tr -d '\r' | tr -d '\n';  done) 

#convert this string into an array
dirArray=($dirs);

# Intialize and clear any existing temp file
touch TempCountFile.csv ;
rm TempCountFile.csv;
touch TempCountFile.csv;


#loop through the array and get the file+dir counts in each directory
for ((i=0; i<${#dirArray[@]}; ++i));  do    
        dirName="${dirArray[$i]}"; 
        count=`(ls ${dirArray[$i]}  | wc -l) | awk '{$1=$1};1'`;
        echo -e "$count, $dirName" >> TempCountFile.csv;
done

# sort and output the TempFile
sort -k1 -n -r TempCountFile.csv ; 
#rm TempCountFile.tsv;



#reset the IFS variable back to before running this script
IFS=$OIFS;


