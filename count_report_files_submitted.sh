#!/bin/bash

function list_reports(){
	# remove any file named reports_count
	rm -rf "$1/reports_count.txt"

	num_csv_files=$( ls "$1"/*.{csv,zip} | wc -l )

	if [[ $num_csv_files == 1 ]]; then
		echo "1 file received:" >> "$1/reports_count.txt"
	elif [[ $num_csv_files > 1 ]]; then
		echo "$num_csv_files files received:" >> "$1/reports_count.txt"
	fi

	for filename in $( ls "$1"/*.{csv,zip} ); do
		echo $(basename $filename) >> "$1/reports_count.txt"
	done
	
	cat "$1/reports_count.txt"

}

export REPORTS_DIR="/home/edulution/reports"

list_reports $REPORTS_DIR
