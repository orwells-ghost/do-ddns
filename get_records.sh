#!/bin/sh

###################
# Ryan Kennedy 12-18-21
# Check various record IDs for DigitalOcean domain

# Source vars
source ./vars.config

# Get response data from DO
response=$(curl \
  --silent \
  -X GET \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  "https://api.digitalocean.com/v2/domains/$DOMAIN/records")

echo $response | grep -Eo '"id":\d*|"type":"\w*"|"data":".*?"'