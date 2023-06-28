#!/bin/bash

# Retrieve the list of nodes from EMR
node_list=$(yarn node -list)

# Extract the EC2 internal addresses
internal_addresses=$(echo "$node_list" | grep -oE 'ip-[0-9]+-[0-9]+-[0-9]+-[0-9]+')

# Convert internal addresses to valid IP addresses
declare -A ip_address_map
count=0
for internal_address in $internal_addresses; do
    # Extract the IP octets
    ip_octets=$(echo "$internal_address" | sed 's/ip-\([0-9]\+\)-\([0-9]\+\)-\([0-9]\+\)-\([0-9]\+\)/\1.\2.\3.\4/')

    # Add the IP address to the map if it doesn't exist
    if [[ ! "${ip_address_map[$ip_octets]}" ]]; then
        ip_address_map[$ip_octets]=1
        ((count++))
    fi
done

# Print the unique valid IP addresses and node count
echo "Valid IP Addresses:"
for ip_address in "${!ip_address_map[@]}"; do
    echo "$ip_address"
done
echo "Number of Nodes: $count"
