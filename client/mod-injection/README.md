# Mod Injection
Mod Injection allows you to inject local mod to the Project Zomboid server. You must be an admin on the server.

## Usage
```text
USAGE:
   ./inject.sh command [arguments...]

VERSION:
   0.1.0

Description:
   This is not the cheat. You must be an admin on the server.

COMMANDS:
   help, h     Shows a list of commands or help for one command
   version, v  Prints inject.sh version
   up          Injects mod
   down        Deletes injected mod
   clear       Deletes all injected mods with custom "mods" directories

GLOBAL OPTIONS:
   --help, -h     show help
   --version, -v  print the version

COPYRIGHT:
   Copyright (c) 2021 Pavel Korotkiy (outdead)
```

## Example

    # from utils root
    DIR_PZ_STEAM="client/mod-injection/testdata/server" DIR_MODS_STORED="/media/pk/hdd/install/games/install/Project Zomboid/mods saved/_develop/mods" ./client/mod-injection/inject.sh up testmod

    # from mod-injection
    cd client/mod-injection

    ./inject.sh up "mod with long name"
    ./inject.sh down "mod with long name"
    ./inject.sh clear
