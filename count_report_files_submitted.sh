#!/bin/bash

export REPORTS_DIR="/home/edulution/reports"

# Function to list the report files submitted
# Args:
# 	Path to directory containing report files in csv or zip format
# Returns:
# 	String: The count and names of report files that are in the directory
# 		A file called reports_count.txt is created as a by-product and posted on Slack via APIs



function list_reports(){
	# remove any file named reports_count
	rm -rf "$1/reports_count.txt"

	# Get a count of the number of csv and zip files
	num_csv_files=$( ls "$1"/*.{csv,zip} | wc -l )

	# If only one csv/zip file is present, print the message below and populate reports_count.txt with it's contents
	if [[ $num_csv_files == 1 ]]; then
		echo "1 file received:" >> "$1/reports_count.txt"
	# If there is more than one csv/zip file, do the same as above but with the count of files received
	elif [[ $num_csv_files > 1 ]]; then
		echo "$num_csv_files files received:" >> "$1/reports_count.txt"
	fi

	# Loop through the filenames and echo their names to reports_count.txt
	for filename in $( ls "$1"/*.{csv,zip} ); do
		#check the current month monthend was submitted 
		month=$(date +%B)
		#Print out the current month and monthend.zip for the center
		echo  "Current Month : $month" +  $(basename $filename) >> "$1/reports_count.txt"
	done
	
	# Display the contents of reports_count.txt
	cat "$1/reports_count.txt"

}


# Numbers of Baseline files received
function list_of_baseline_files {
	#check baseline file for the current month 
	month=$(date +%B)
	#Current check monthend.zip file and check for baseline file
	num_baseline_files=$( unzip -l .{csv,zip} | grep -q baseline && echo $? )
	#Print out the current month and baseline file the center
	echo "Current Month : $month" + "$num_baseline_files files received:" 

}


# Call the function above with the reports_dir supplied
list_reports "$REPORTS_DIR"
