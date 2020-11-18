#!/bin/bash

WAZUH_CONFIG_DIR=/var/ossec/etc/
WAZUH_CONFIG_PATH=/var/ossec/etc/ossec.conf
WAZUH_VERSION=4.0.0-1

# Cant do this step in Dockerfile because it registers the agent with server
WAZUH_MANAGER=wazuh WAZUH_AGENT_NAME=victim apt-get install -y wazuh-agent="${WAZUH_VERSION}"

until [[ -f ${WAZUH_CONFIG_PATH} ]]
do
  echo "Waiting on ${WAZUH_CONFIG_PATH} to be available"
  sleep 5
done

# Move in custom configs
mv -fv /tmp/ossec.conf /tmp/internal_options.conf "${WAZUH_CONFIG_DIR}"
/var/ossec/bin/ossec-control restart