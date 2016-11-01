#!/bin/bash -ex
cd `dirname $0`
set +e
HUGO=`which hugo`
set -e
if [ "${HUGO}" == "" ]; then
  HUGO_VER=0.17
  if [ ! -f .build/hugo_${HUGO_VER}_linux_amd64/hugo_${HUGO_VER}_linux_amd64 ]; then
    mkdir -p .build
    tar -xzvf .jenkins/distrib/hugo_${HUGO_VER}_linux-64bit.tgz -C .build
  fi
  HUGO=".build/hugo_${HUGO_VER}_linux_amd64/hugo_${HUGO_VER}_linux_amd64"
fi
${HUGO} $@
