#!/bin/bash

set -e

# It is recommended to compile and protect the script using shc (poweron.sh (bash) -> poweron.sh.x (elf)):
#
# shc -f poweron.sh -> poweron.sh.x

IPMI_TOOL="$(type -p ipmitool)"

echo "Using ipmitool: '${IPMI_TOOL}'"

IPMI_HOST=192.168.253.110
IPMI_USER=power
IPMI_PASSWORD=# Place BASE64 encoded password here
IPMI_ROLE=OPERATOR

echo "Power on main server over IPMI"
${IPMI_TOOL} -H "${IPMI_HOST}" \
             -U "${IPMI_USER}" \
             -P "$(echo "${IPMI_PASSWORD}" | base64 -d)" \
             -L "${IPMI_ROLE}" \
             power on
rc=0

if [ ${rc} -ne 0 ]; then
    echo "ipmitool: command failed on host '${IPMI_HOST}'"
    exit 1
fi

echo "ipmitool: command successfully executed on host '${IPMI_HOST}'"
