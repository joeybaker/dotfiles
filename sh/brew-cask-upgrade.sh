#!/usr/bin/env bash

set -e

STAGING_LOCATION="$(brew cask doctor \
    | grep -A1 '==> Homebrew-cask Staging Location:' | tail -n1)"

echo "==> Upgrading casks"
for cask in $(ls ${STAGING_LOCATION})
do
    case "${cask}" in
        tunnelblick)
            echo "Skip ${cask}"
            ;;
        *)
            brew cask install "${cask}"
            ;;
    esac
done

echo "==> Uninstalling casks"
_trash() {
    if [ -z "$(command -v trash)" ]
    then
        echo >&2 "Please install trash: brew install trash"
        exit 1
    fi
    if [ -e "$1" ]
    then
        trash "$1"
        echo "trash $1: success"
    else
        echo "trash $1: missing"
    fi
}
_list_old_versions() {
    for path in "$@"
    do
        if [ -e "$1" ]
        then
            ls -1tr "$1" | sed '$d'
        fi
    done
}
for cask in $(ls ${STAGING_LOCATION})
do
    for version in $(_list_old_versions \
            "${STAGING_LOCATION}/${cask}" \
            "${STAGING_LOCATION}/${cask}/.metadata")
    do
        echo "Clean ${cask} ${version}"
        _trash "${STAGING_LOCATION}/${cask}/${version}"
        _trash "${STAGING_LOCATION}/${cask}/.metadata/${version}"
    done
done
