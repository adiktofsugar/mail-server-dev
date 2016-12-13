#!/bin/bash
set -eu -o pipefail
project_root="$(cd `dirname ${BASH_SOURCE[0]}`; pwd)"

usage="
uninstall.sh
 -h - this help
Uninstalls the fake smtp server at port 1025, which sends everything to $USER@localhost
"

while getopts ":h" opt; do
    case "$opt" in
        h) echo "$usage"; exit;;
    esac
done

plist_name="local.mail-server-dev"
plist_path="$HOME/Library/LaunchAgents/local.mail-server-dev.plist"
if [[ -e "$plist_path" ]]; then
    launchctl stop "$plist_name"
    launchctl unload "$plist_path"
    rm "$plist_path"
fi
echo "Removed local.mail-server-dev from plist. Dovecot is still installed. Use 'brew uninstall dovecot' to remove."
