#!/bin/bash

# Retrieve the list of nodes from EMR
node_list=$(yarn node -list)

# Extract the EC2 internal addresses
internal_addresses=$(echo "$node_list" | grep -oE 'ip-[0-9]+-[0-9]+-[0-9]+-[0-9]+')

# Convert internal addresses to valid IP addresses
valid_ip_addresses=""
for internal_address in $internal_addresses; do
    # Extract the IP octets
    ip_octets=$(echo "$internal_address" | sed 's/ip-\([0-9]\+\)-\([0-9]\+\)-\([0-9]\+\)-\([0-9]\+\)/\1.\2.\3.\4/')

    # Append the valid IP address to the result
    valid_ip_addresses+="$ip_octets "
done

# Print the valid IP addresses
echo "Valid IP Addresses:"
echo "$valid_ip_addresses"