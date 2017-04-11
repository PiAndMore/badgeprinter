#!/bin/bash

echo "SELECT name, ticket FROM badges WHERE ticket != '' ORDER BY random() LIMIT 100;" | sqlite3 badges.db -batch # | sm -
