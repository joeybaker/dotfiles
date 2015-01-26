#!/bin/bash
# strict mode http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail
IFS=$'\n\t'

macRandomizify(){
  local INTERFACE=en0
  local OUI="$HOME/Dropbox/dotfiles/sh/oui.txt"
  local OUI_LEN=19004

#  while [ true ]; do
      local STATUS=`ifconfig ${INTERFACE}\
        | grep status:\
        | awk '{print $2}'`

      if [ "$STATUS" = "inactive" ]; then
          local R=$(((RANDOM % ${OUI_LEN})+1))
          local PREFIX=`head -$R $OUI\
            | tail -1`

          local CMD="sudo ifconfig ${INTERFACE} ether ${PREFIX}:"

          for i in `seq 1 6`; do
              R=$(((RANDOM % 15)+1))
              C=`echo "obase=16; $R" | bc`
              CMD="$CMD$C"
              if [ $((i % 2)) = 0 ] && [ $i != 6 ]; then
                  CMD="$CMD:"
              fi
          done
          local RESULT=`$CMD`
          echo $CMD
      else
        echo $STATUS
      fi
#      sleep 30
#  done
}

macRandomizify;

