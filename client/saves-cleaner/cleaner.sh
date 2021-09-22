#!/usr/bin/env bash

VERSION="0.1.0"
YEAR="2021"
AUTHOR="Pavel Korotkiy (outdead)"

BASEDIR=$(dirname "$0")

# DIR_PZ_STEAM is the path to installed Project Zomboid.
if [[ -z ${DIR_PZ_SAVES} ]]; then DIR_PZ_SAVES=~/"Zomboid/Saves/Multiplayer"; fi

function init() {
    [[ -d "${DIR_PZ_SAVES}" ]] || { echo "Saves is not set"; return 1; }

    DIR_SAVE=$(echo "outdead" | md5sum)
}

init

echo "${DIR_SAVE}"
echo "not implemented"
