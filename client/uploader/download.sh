#!/usr/bin/env bash

VERSION="0.1.0"
YEAR="2021"
AUTHOR="Pavel Korotkiy (outdead)"

# Color variables. Used when displaying messages in stdout.
RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[0;33m'; BLUE='\033[0;36m'; NC='\033[0m'

# Message types. Used when displaying messages in stdout.
OK=$(echo -e "[ ${GREEN} OK ${NC} ]"); ER=$(echo -e "[ ${RED} ER ${NC} ]"); INFO=$(echo -e "[ ${BLUE}INFO${NC} ]")

# BASEDIR contains script directory. Note: Not all systems have readlink.
BASEDIR=$(dirname "$(readlink -f "$BASH_SOURCE")")

# Import config file if exists.
if [ -n "$1" ]; then
  SERVER_TYPE="$1"
  FILE_DEPLOY_CONFIG="${BASEDIR}/include/config/${SERVER_TYPE}.sh"
  test -f "${FILE_DEPLOY_CONFIG}" && . "${FILE_DEPLOY_CONFIG}"
fi

# Or get variables from env if exists.
SERVER_IP=${SERVER_IP}
SERVER_USER=${SERVER_USER}
SERVER_PASSWORD=${SERVER_PASSWORD}

[[ -z "${SERVER_IP}" ]] && >&2 echo "$ER SERVER_IP is not set" && exit
[[ -z "${SERVER_USER}" ]] && >&2 echo "$ER SERVER_USER is not set" && exit
[[ -z "${SERVER_PASSWORD}" ]] && >&2 echo "$ER SERVER_PASSWORD is not set" && echo "${SERVER_IP}" && exit

DIR="${BASEDIR}/data/from/${SERVER_TYPE}/$(date +%Y-%m-%d_%H-%M-%S)"
mkdir -p "${DIR}"

exp "${SERVER_PASSWORD}" scp -r -o 'IdentitiesOnly=yes' "${SERVER_USER}@${SERVER_IP}":/home/outdead/pz/content/gc.out "${DIR}/gc.out"
#exp "${SERVER_PASSWORD}" scp -r -o 'IdentitiesOnly=yes' "${SERVER_USER}@${SERVER_IP}":/home/outdead/pz/content/Zomboid/logs.tar.gz "${DIR}/logs.tar.gz"
