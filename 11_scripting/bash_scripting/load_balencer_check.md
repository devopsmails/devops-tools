#!/bin/bash
################
#installing apache2
###############
sudo apt update -y
sudo apt upgrade -y
sudo apt install apche2 -y
 echo "<h1>Server Details</h1><p><strong>Hostname: </strong> $(hostname)</p><p><strong>IP address: </strong> $(hostname -i | cut -d "" -f1)</p>"> /var/www/html/index.html
 sudo systemctl restart apche2