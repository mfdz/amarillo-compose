#!/usr/bin/env sh
# Shell script to update sample data for Amarillo

#1. Create agencyconf/mfdz (if it doesn't exist already) and print the api key to the console

file=sampledata/agencyconf/mfdz.json
if [ -e "$file" ]; then
    echo "$file already exists"
else 
    # https://security.stackexchange.com/questions/183948/unix-command-to-generate-cryptographically-secure-random-string
    api_key=$(LC_ALL=C tr -dc '[:alnum:]' < /dev/urandom | head -c20)

    mfdz_json=`cat <<EOF
    {
        "agency_id":"mfdz",
        "api_key": "$api_key"
    }
EOF
    `
    mkdir -p data/agencyconf;
    echo ${mfdz_json} > $file && echo "agencyconf/mfdz.json created with api key '$api_key'"
fi 

#2. Update trips relative to current date

now=$(date -u +"%Y-%m-%dT%H:%M:%SZ") # e.g. "2025-01-22T12:52:24Z"
last_updated_replace_string='s/(.*"lastUpdated":\s*")[^"]*(".*)/\1'$now'\2/g' # sets "lastUpdated" field to $now

#args:  $1: trip_id,  $2: relative_date
update_carpool_with_date() {

    file="sampledata/carpool/mfdz/$1.json"
    if [ -n "$2" ]; then
        # set "departureDate" field relative to today with the `date` command
        new_departure_date=$(date -I --date "$2")
        departure_date_replace_string='s/(.*"departureDate":\s*")[^"]*(".*)/\1'$new_departure_date'\2/g'
        sed -i -E $departure_date_replace_string $file
    fi 

    sed -i -E $last_updated_replace_string $file
    echo "Updated $file"
  
}

#                    trip_id   relative_date
update_carpool_with_date "1001"    "today"
update_carpool_with_date "1002"    "tomorrow"
update_carpool_with_date "1003"                    # repeating trip; only set 'lastUpdated' time
update_carpool_with_date "1004"    "next week"

