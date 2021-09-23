#!/usr/bin/env bash

VERSION="0.1.0"
YEAR="2021"
AUTHOR="Pavel Korotkiy (outdead)"

BASEDIR=$(dirname "$0")

if [ -f "$BASEDIR"/.env ]; then
  export $(cat "$BASEDIR"/.env | sed 's/#.*//g' | xargs)
fi

if [[ -z ${DIR_PZ_SAVES} ]]; then DIR_PZ_SAVES=~/"Zomboid/Saves/Multiplayer"; fi


function init() {
  [[ -d "${DIR_PZ_SAVES}" ]] || { echo "No saves directory found"; return 1; }
  if [[ -z ${SERVER_IP} ]]; then echo "Server ip is not set"; return 1; fi
  if [[ -z ${SERVER_PORT} ]]; then echo "Server port is not set"; return 1; fi
  if [[ -z "${USERNAME}" ]]; then echo "Username is not set"; return 1; fi

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
