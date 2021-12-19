 #!/bin/sh

###################
# Ryan Kennedy 12-18-21
# Check current IP against a log of latest IPs
# Update DigitalOcean DNS record with new IP if IP address has changed 

# Source vars
source ./vars.config

# get current ip from opendns.com, check previous ip from log file
DETECTED_IP="$(dig +short myip.opendns.com @resolver1.opendns.com)"
PREVIOUS_IP="$(tail -1 $LOG_FILE | awk -F, '{print $2}')"

if [ "$DETECTED_IP" = "$PREVIOUS_IP" ]
then

	echo "Previous IP -> ($PREVIOUS_IP)."
	echo "Detected IP -> ($DETECTED_IP)."
	echo "No change detected, exiting."

else

	echo "Previous IP -> ($PREVIOUS_IP)."
	echo "Detected IP -> ($DETECTED_IP)."
	echo "New public IP detected, updating DigitalOcean records…" && echo
	echo "$(date),$DETECTED_IP" >> "$LOG_FILE" # write date,detected_ip to log file

	# Update dns record with new ip
	curl \
		-X PUT \
		-H "Content-Type: application/json" \
		-H "Authorization: Bearer $ACCESS_TOKEN" \
		-d '{"data":"'"$DETECTED_IP"'"}' \
		"https://api.digitalocean.com/v2/domains/$DOMAIN/records/$RECORD_ID"
fi