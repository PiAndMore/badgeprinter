#!/bin/bash

echo "SELECT name, ticket FROM badges WHERE ticket != '' ORDER BY random() LIMIT 1;" | sqlite3 badges.db -batch | sm -
