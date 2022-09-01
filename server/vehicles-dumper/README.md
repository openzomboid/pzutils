# Vehicles-dumper
Vehicles Dumper dumps vehicles coordinates to file.

## Usage

    python3 vehicles-dumper.py -s servertest -z /home/pk/Zomboid

File `vehicles.txt` will be created on `Zomboid/Lua` folder with content:
```text
11703,4193,0
6787,5325,0
7148,9632,0
12030,3010,0
13416,1751,0
6694,5327,0
```

You can add execution of `vehicles-dumper.py` to cron and update file every X minutes:

    crontab -e
    */5  * * * * python3 /home/pzuser/pzserver/vehicles-dumper.py -s servertest -z /home/pzuser/Zomboid
