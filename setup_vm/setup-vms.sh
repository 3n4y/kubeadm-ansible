#!/bin/bash

function set_hosts() {
# remove default entry in hosts
sed -i '/^127\..* '"$HOSTNAME"' .*$/d' -i /etc/hosts
}

set -e
HOST_NAME=$(hostname)
OS_NAME=$(awk -F= '/^NAME/{print $2}' /etc/os-release | grep -o "\w*"| head -n 1)

if [[ $HOST_NAME == *kubemaster* ]]; then
  case "${OS_NAME}" in
    "CentOS")
      sudo yum install -y epel-release
      sudo yum install -y git ansible sshpass python-netaddr openssl-devel
    ;;
    "Ubuntu")
      sudo apt-get update && sudo apt-get install -y ansible git sshpass libssl-dev
    ;;
    *)
      echo "${OS_NAME} is not support ..."; exit 1
  esac

  set_hosts
else
  set_hosts
fi
