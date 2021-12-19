# Custom DDNS Bash Script

Simple script to update a DigitalOcean DNS record with a new IP address if the IP address changes.

## Installation

Clone or download this repo. Remember to create variable file.

### Variables
Script require a `vars.config` file to store variables. Create with:

```bash
touch vars.config
```

Variables required are `ACCESS_TOKEN`, `DOMAIN`, `RECORD_ID`, and `LOG_FILE`.

`vars.config` file should look like:

```bash
ACCESS_TOKEN=your_token_here
DOMAIN=example.com
RECORD_ID=1110008679309
LOG_FILE="./DO_update_logs.txt"
```

`ACCESS_TOKEN` is provided by a DigitalOcean account to access DO's API.

`DOMAIN` is the domain from which you require  the records.

`RECORD_ID` is an ID of an individual DNS record of a domain. Can get DNS record ID using `get_records.sh` script.

## Usage
Run `get_records.sh` and it will return a list of all of the DNS records associated with the specified DOMAIN. Select the RECORD_ID you wish to access and update the `vars.config` file. 

Run `update_dns.sh` and it will detect the current IP and check it against the log of IPs. If the IP address has not changed, only a message will appear. If the IP **has** changed, the log will be updated with the new IP and the DNS record specified by RECORD_ID will be updated with the new IP address.

## License
[MIT](https://choosealicense.com/licenses/mit/)