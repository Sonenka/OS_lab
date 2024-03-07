#!/bin/bash

#check the number of command-line arguments
if [ "$#" -ne 3 ]; then
	echo "User: &0 <login_prefix> <start_number> <end_number>"
	exit 1
fi

prefix=$1
start=$2
end=$3

#check the correctness of the ordinal numbers
if [ $end -lt $start ]; then
	echo "Error: end_number must be more or equal to start_number."
	exit 1
fi

#create the user.csv file
echo "Generating users.csv"
rm -f users.csv

for ((i=start; i<=end; i++)); do
	password=$(pwgen 12 1) #generate a 12-character password
	user="$prefix"_"$i"
	echo "$user,$password" >> users.csv
done

echo "user.csv has generated."
