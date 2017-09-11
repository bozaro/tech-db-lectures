#!/bin/bash -ex
cd `dirname $0`
HUGO_VER=0.27
OS=`uname`
case "${OS}" in
	Linux)
		HUGO_DIST="hugo_${HUGO_VER}_Linux-64bit.tar.gz"
		;;
	Darwin)
		HUGO_DIST="hugo_${HUGO_VER}_macOS-64bit.tar.gz"
		;;
	*)
		echo "Unknown OS: ${OS}"
		exit 1
		;;
esac

HUGO_DIR=".build/${OS}_${HUGO_VER}"
HUGO="${HUGO_DIR}/hugo"
if [ ! -f "${HUGO}" ]; then
	mkdir -p "${HUGO_DIR}"
	mkdir -p ".jenkins"
	if [ ! -f ".jenkins/${HUGO_DIST}" ]; then
		wget -v -c -O ".jenkins/${HUGO_DIST}~" "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VER}/${HUGO_DIST}"
		mv ".jenkins/${HUGO_DIST}~" ".jenkins/${HUGO_DIST}"
	fi
	tar -xzvf ".jenkins/${HUGO_DIST}" -C "${HUGO_DIR}/"
fi

"${HUGO}" $@
find public/ -iname ".*" -exec rm {} \;
