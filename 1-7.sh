#!/bin/bash

# Function to display help message
display_help() {
  echo "Usage: $0 <login_prefix> <start_number> <end_number>"
}

# Check if '-h' is provided as a command-line argument
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

# Check the correctness of the ordinal numbers
if [ $3 -lt $2 ]; then
  echo "Error: end_number must be greater than or equal to start_number."
  exit 1
fi

# Function to generate users.csv
generate_users_csv() {
  rm -f users.csv
  for ((i=$2; i<=$3; i++)); do
    password=$(pwgen 12 1) # Generate a 12-character password
    user="${1}_${i}"
    echo "$user,$password" >> users.csv
  done
}

if [ "$#" -eq 3 ]; then
  # If all arguments are provided via command-line
  prefix=$1
  start=$2
  end=$3
  generate_users_csv $prefix $start $end
  echo "user.csv has been generated."
else
  # If not all arguments are provided, prompt for input
  read -p "Enter login prefix: " prefix
  read -p "Enter start number: " start
  read -p "Enter end number: " end

  if [ $end -lt $start ]; then
    echo "Error: end_number must be greater than or equal to start_number."
    exit 1
  fi

  generate_users_csv $prefix $start $end
  echo "user.csv has been generated."
fi
