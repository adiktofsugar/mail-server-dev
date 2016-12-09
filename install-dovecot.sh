#!/bin/bash
set -eu -o pipefail
project_root="$(cd `dirname ${BASH_SOURCE[0]}`; pwd)"

usage="
install-dovecot.sh
 -h - this help
Conditionally installs dovecot
Unconditionally generates the configuration
Installs or Restarts the service
"

while getopts ":h" opt; do
    case "$opt" in
        h) echo "$usage"; exit;;
    esac
done

if ! [[ -e "/usr/local/sbin/dovecot" ]]; then
    brew install dovecot
fi

$project_root/install-dovecot-conf.sh

if ! [[ -e "/Library/LaunchDaemons/homebrew.mxcl.dovecot.plist" ]]; then
    sudo brew services start dovecot
else
    sudo brew services restart dovecot
fi
