#!/bin/bash

/init_scripts/suricata.sh

until [[ -f /var/log/suricata/eve.json ]]
do
     echo "Waiting for Suricata logs to be available"
     sleep 5
done

/init_scripts/wazuh.sh
/init_scripts/merlin.sh

#tail -F /var/log/merlin/merlin.log /var/ossec/logs/ossec.log /var/log/suricata/suricata.log
tail -F /var/log/merlin/merlin.log
