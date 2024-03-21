#!/bin/bash

# Function to display help message
display_help() {
  echo "Usage: $0 <login_prefix> <start_number> <end_number>"
}

# Check if -h option is provided
if [[ "$1" == "-h" ]]; then
  display_help
  exit 0
fi

# Check the number of command-line arguments
if [ "$#" -ne 3 ]; then
  echo "Error: Incorrect number of arguments."
  display_help
  exit 1
fi

prefix=$1
start=$2
end=$3

# Check the correctness of the ordinal numbers
if [ $end -lt $start ]; then
  echo "Error: end_number must be greater than or equal to start_number."
  exit 1
fi

# Function to generate users.csv
generate_users_csv() {
  rm -f users.csv
  for ((i=start; i<=end; i++)); do
    password=$(pwgen 12 1) # Generate a 12-character password
    user="${prefix}_${i}"
    echo "$user,$password" >> users.csv
  done
}

generate_users_csv
echo "user.csv has been generated."
