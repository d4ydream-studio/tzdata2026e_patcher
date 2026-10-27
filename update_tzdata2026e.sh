#!/bin/bash 

VERSION="EST"

mkdir tzdb
cd tzdb

# Get the data files from IANA

wget https://data.iana.org/time-zones/releases/tzdata2026e.tar.gz

# Extract the 2026e files

tar zxf tzdata2026e.tar.gz

# Run 'zic' to update the local files

/usr/sbin/zic -d /usr/share/zoneinfo -L leapseconds africa asia europe northamerica southamerica backward

# Set the timezone to force an update to /etc/localtime

timedatectl set-timezone America/Winnipeg

# Check that  /etc/localtime has been updated to 'EST' as the temporary fix from IANA

if [[ "$(date | awk '{print $6}')" == "$VERSION" ]]; then
    echo 'Success!'
                exit 0
else
    echo 'Fail!'
                exit 1
fi
