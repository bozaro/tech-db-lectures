#!/bin/bash -ex
cd `dirname $0`
./hugo.sh server -w -b http://localhost/
