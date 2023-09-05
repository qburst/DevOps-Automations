#!/bin/bash

# Specify the username
username=""

# Path to user's home directory
home_directory="/home/$username"

# Path to list of domains file
domain_list="$home_directory/OpenSource-DevOps/DevOps-Automations/scripts/domain-expiry-check/domain_list.txt"

# Set the threshold value
days_threshold=60

# Email address to receive the alert
email_address=""

# Funtion to check if they year is a Leap year or not
is_leap_year() {
	year="$1"
	((year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)))
}

# Function to print a formatted table row
print_table_row() {
	printf "| %-30s | %-16s | %-18s |\n" "$1" "$2" "$3"
}

# Function to check domains's expiry date and send alert
expiry_date_check() {
	echo "+--------------------------------+------------------+--------------------+"
	echo "|          Domain Name           |   Expiry Date    |      Status        |"
	echo "+--------------------------------+------------------+--------------------+"

	alerts=""

	while read -r line
	do

		expiry_date=$(whois $line | grep "Registry Expiry Date" | awk -F: '{print $2}' | cut -d 'T' -f1 | xargs)
		registrar_url=$(whois $line | grep -i "Registrar URL")

		if [ -z "$expiry_date" ]; then
			print_table_row "$line" "N/A" "Error"
			alerts+="<b>Invalid/Unable to Fetch</b>: The domain <b>"$line"</b> is either invalid or we couldn't retrieve the expiry date. Please verify the domain details.<br>"

		else
			current_date=$(date +%s --utc)
			expiry_timestamp=$(date -d "$expiry_date" +%s --utc)

			days_until_expiry=$(( (expiry_timestamp - current_date) /86400 ))

			year=$(date -d "$expiry_date" +%Y)

			if is_leap_year "$year"; then
				days_until_expiry=$((days_until_expiry + 1))
			fi

			if [ "$days_until_expiry" -le "$days_threshold" ] && [ "$expiry_timestamp" -ge "$current_date" ] && [ "$expiry_timestamp" != "$current_date" ]; then
				print_table_row "$line" "$expiry_date" "Expiring Soon"
				alerts+="<p style='color:red'><b>Expiring Soon</b>: The domain <b>$line</b> will expire on <b>$expiry_date</b> ("$days_until_expiry" days remaining). Please take action. ["$registrar_url"]<br></p>"

			elif [ "$days_until_expiry" -ge "$days_threshold" ]; then
				print_table_row "$line" "$expiry_date" "OK"
				# No actions required

			elif [ "$expiry_timestamp" -le "$current_date" ] && [ "$expiry_timestamp" != "$current_date" ]; then
				print_table_row "$line" "$expiry_date" "Expired"
				alerts+="<p style='color:red'><b>Expired</b>: The domain <b>$line</b> expired on <b>$expiry_date</b>. Please take action. ["$registrar_url"]<br></p>"

			elif [ "$expiry_timestamp" == "$current_date" ]; then
				print_table_row "$line" "$expiry_date" "Expiring today"
				alerts+="<p style='color:red'><b>Expiring Today</b>: The domain <b>$line</b> is expiring <b>today</b>. Please take action. ["$registrar_url"]<br></p>"

			else
				# Handles any other unexpected scenario
				echo "Unable to fetch "$line"'s expiry date"

			fi
		fi
	done < "$domain_list"
	echo "+--------------------------------+---------------+-----------------------+"

	if [ -n "$alerts" ]; then
		echo -e "$alerts" | mutt -e "set content_type=text/html" -s "Domain Expiry Alert" "$email_address"
	fi

}

expiry_date_check
