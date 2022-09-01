#!/usr/bin/python3

# Vehicles Dumper dumps vehicles coordinates to file
#
# Copyright (c) 2022 Pavel Korotkiy (outdead).
# Use of this source code is governed by the MIT license.

import sys, getopt
import sqlite3


def main(argv):
    servername = ''
    path_to_zomboid = ''

    try:
        opts, args = getopt.getopt(argv, "hs:z:", ["servername=","zomboid="])
    except getopt.GetoptError:
        print('Usage: vehicles-dumper.py -s <servername> -z <path/to/Zomboid>')
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print('Usage: vehicles-dumper.py -s <servername> -z <path/to/Zomboid>')
            sys.exit()
        elif opt in ("-s", "--sevrername"):
            servername = arg
        elif opt in ("-z", "--zomboid"):
            path_to_zomboid = arg

    if servername == '' or path_to_zomboid == '':
        print('Usage: vehicles-dumper.py -s <servername> -z <path/to/Zomboid>')
        sys.exit(2)

    path_to_vehicles_db = path_to_zomboid + '/Saves/Multiplayer/' + servername + '/vehicles.db'
    path_to_file = path_to_zomboid + '/Lua/vehicles.txt'

    connection = sqlite3.connect(path_to_vehicles_db)
    cursor = connection.cursor()

    cursor.execute("SELECT cast(round(x) as int) as x, cast(round(y) as int) as y, 0 as z FROM vehicles")
    records = cursor.fetchall()

    f = open(path_to_file, "w")

    for row in records:
        x = str(row[0])
        y = str(row[1])
        z = str(row[2])

        f.write(x + ',' + y + ',' + z + '\n')

    f.close()


if __name__ == "__main__":
    main(sys.argv[1:])
