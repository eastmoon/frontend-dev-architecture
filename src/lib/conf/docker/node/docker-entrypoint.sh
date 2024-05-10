#!/bin/sh
# vim:sw=4:ts=4:et
set -e

if [ "${1}" = "node" ]; then
    npm install
    npm run start
elif [ "${1}" = "build" ]; then
    npm install
    npm run build
else
    exec "${@}"
fi
