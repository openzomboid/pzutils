#!/usr/bin/env bash

VERSION="0.1.1"
YEAR="2021"
AUTHOR="Pavel Korotkiy (outdead)"

BASEDIR=$(dirname "$0")

[[ -f "${BASEDIR}"/.env ]] &&  export $(cat "${BASEDIR}"/.env | sed 's/#.*//g' | xargs)

[[ -z "${DIR_PZ_SAVES}" ]] && DIR_PZ_SAVES=~/"Zomboid/Saves/Multiplayer"

function init() {
  [[ -d "${DIR_PZ_SAVES}" ]] || { echo "No saves directory found"; return 1; }
  [[ -z "${SERVER_IP}" ]] && { echo "Server ip is not set"; return 1; }
  [[ -z "${SERVER_PORT}" ]] && { echo "Server port is not set"; return 1; }
  [[ -z "${USERNAME}" ]] && { echo "Username is not set"; return 1; }

  DIR_SAVE="${DIR_PZ_SAVES}/${SERVER_IP}_${SERVER_PORT}_$(echo -n "${USERNAME}" | md5sum | awk '{print $1}')"

  [[ -d "${DIR_SAVE}" ]] || { echo "No user saves directory found"; return 1; }
}

function clear() {
  rm -rf "${DIR_SAVE}"/map_*_*.bin
  echo "Username: ${USERNAME}"
  echo "Saves dir: ${DIR_SAVE}"
  echo ""
  ls "${DIR_SAVE}"
}

init && clear
