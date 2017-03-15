#!/bin/bash
DB=movielens
set -e -x
dropdb --if-exists $DB
wget -c http://files.grouplens.org/datasets/movielens/ml-latest.zip
unzip -o ml-latest.zip
createdb $DB
psql $DB < load-pgsql.sql
pg_dump $DB > ml-latest.sql
