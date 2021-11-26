#!/usr/bin/env bash

VERSION="0.1.0"
YEAR="2021"
AUTHOR="Pavel Korotkiy (outdead)"

BASEDIR=$(dirname "$0")

# DIR_PZ_STEAM is the path to installed Project Zomboid.
[[ -z ${DIR_PZ_STEAM} ]] && DIR_PZ_STEAM=~/".local/share/Steam/steamapps/common/ProjectZomboid"

# DIR_MODS_STORED is the path to local saved mods.
[[ -z ${DIR_MODS_STORED} ]] && DIR_MODS_STORED="${BASEDIR}/mods"

function init() {
    [[ -d "${DIR_PZ_STEAM}" ]] || { echo "Project Zomboid is not installed"; return 1; }
    [[ -d "${DIR_MODS_STORED}" ]] || { echo "no mods to inject"; return 1; }

    DIR_PZ_MEDIA="${DIR_PZ_STEAM}/projectzomboid/media"
}

# up injects mod with name $1.
function up() {
    local mod_name="$1"
    [[ -z "${mod_name}" ]] && { echo "mod name is not set"; return 1; }

    local mod_path="${DIR_MODS_STORED}/${mod_name}"
    [[ -d "${mod_path}" ]] || { echo "mod to inject does not exists"; return 1; }

    mkdir -p "${DIR_PZ_MEDIA}/lua/shared/mods"
    mkdir -p "${DIR_PZ_MEDIA}/lua/server/mods"
    mkdir -p "${DIR_PZ_MEDIA}/lua/client/mods"
    mkdir -p "${DIR_PZ_MEDIA}/scripts/mods"
    mkdir -p "${DIR_PZ_MEDIA}/sound/mods"
    mkdir -p "${DIR_PZ_MEDIA}/textures/mods"
    mkdir -p "${DIR_PZ_MEDIA}/ui/mods"

    [[ -d "${mod_path}/media/lua/shared" ]] && cp -r "${mod_path}/media/lua/shared" "${DIR_PZ_MEDIA}/lua/shared/mods/${mod_name}"
    [[ -d "${mod_path}/media/lua/server" ]] && cp -r "${mod_path}/media/lua/server" "${DIR_PZ_MEDIA}/lua/server/mods/${mod_name}"
    [[ -d "${mod_path}/media/lua/client" ]] && cp -r "${mod_path}/media/lua/client" "${DIR_PZ_MEDIA}/lua/client/mods/${mod_name}"
    [[ -d "${mod_path}/media/scripts" ]]    && cp -r "${mod_path}/media/scripts/" "${DIR_PZ_MEDIA}/scripts/mods/${mod_name}"
    [[ -d "${mod_path}/media/sound" ]]      && cp -r "${mod_path}/media/sound/" "${DIR_PZ_MEDIA}/sound/mods/${mod_name}"
    [[ -d "${mod_path}/media/textures" ]]   && cp -r "${mod_path}/media/textures/" "${DIR_PZ_MEDIA}/textures/mods/${mod_name}"
    [[ -d "${mod_path}/media/ui" ]]         && cp -r "${mod_path}/media/ui/" "${DIR_PZ_MEDIA}/ui/mods/${mod_name}"
}

# down deletes injected mod with name $1.
function down() {
    local mod_name="$1"
    [[ -z "${mod_name}" ]] && { echo "mod name is not set"; return 1; }

    [[ -d "${DIR_MODS_STORED}/${mod_name}/media/lua/shared" ]] && rm -r "${DIR_PZ_MEDIA}/lua/shared/mods/${mod_name}"
    [[ -d "${DIR_MODS_STORED}/${mod_name}/media/lua/server" ]] && rm -r "${DIR_PZ_MEDIA}/lua/server/mods/${mod_name}"
    [[ -d "${DIR_MODS_STORED}/${mod_name}/media/lua/client" ]] && rm -r "${DIR_PZ_MEDIA}/lua/client/mods/${mod_name}"
    [[ -d "${DIR_MODS_STORED}/${mod_name}/media/scripts" ]]    && rm -r "${DIR_PZ_MEDIA}/scripts/mods/${mod_name}"
    [[ -d "${DIR_MODS_STORED}/${mod_name}/media/sound" ]]      && rm -r "${DIR_PZ_MEDIA}/sound/mods/${mod_name}"
    [[ -d "${DIR_MODS_STORED}/${mod_name}/media/textures" ]]   && rm -r "${DIR_PZ_MEDIA}/textures/mods/${mod_name}"
    [[ -d "${DIR_MODS_STORED}/${mod_name}/media/ui" ]]         && rm -r "${DIR_PZ_MEDIA}/ui/mods/${mod_name}"
}

# clear deletes all injected mods and custom "mods" directories.
function clear() {
    rm -r "${DIR_PZ_MEDIA}/lua/shared/mods"
    rm -r "${DIR_PZ_MEDIA}/lua/server/mods"
    rm -r "${DIR_PZ_MEDIA}/lua/client/mods"
    rm -r "${DIR_PZ_MEDIA}/scripts/mods"
    rm -r "${DIR_PZ_MEDIA}/sound/mods"
    rm -r "${DIR_PZ_MEDIA}/textures/mods"
    rm -r "${DIR_PZ_MEDIA}/ui/mods"
}

case "$1" in
    up)
        init && up "$2";;
    down)
        init && down "$2";;
    clear)
        init && clear;;
    version|v|--version|-v)
        echo "$0 version ${VERSION}";;
    help|h|--help|-h)
        echo "NAME:"
        echo "   ${0##*/} script allows you to inject local mod to the Project Zomboid server. You must be an admin on the server."
        echo
        echo "USAGE:"
        echo "   $0 command [arguments...]"
        echo
        echo "VERSION:"
        echo "   ${VERSION}"
        echo
        echo "Description:"
        echo "   This is not the cheat. You must be an admin on the server."
        echo
        echo "COMMANDS:"
        echo "   help, h     Shows a list of commands or help for one command"
        echo "   version, v  Prints $0 version"
        echo "   up          Injects mod"
        echo "   down        Deletes injected mod"
        echo "   clear       Deletes all injected mods with custom \"mods\" directories"
        echo
        echo "GLOBAL OPTIONS:"
        echo "   --help, -h     show help"
        echo "   --version, -v  print the version"
        echo
        echo "COPYRIGHT:"
        echo "   Copyright (c) $YEAR ${AUTHOR}"
esac
