#!/bin/bash
# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

start_slides() {
  local title
  local f
  f=$1
  title=$2

  nodemon -x markdown-to-slides -e md -- -t "$title" -o index.html -d "$f" \
    & httpserve 9001 \
    & browser-sync start --proxy localhost:9001 --port 9000 --files "index.html"
}

start_slides $@
