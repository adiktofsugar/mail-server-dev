#!/bin/bash
set -eu -o pipefail
project_root="$(cd `dirname ${BASH_SOURCE[0]}`; pwd)"

usage="
install-smtp-server.sh
 -h - this help
Installs smtp server as a service, so that the smtp server will start on boot, and starts it
Sends a test mail
"

while getopts ":h" opt; do
    case "$opt" in
        h) echo "$usage"; exit;;
    esac
done

contents="$(cat $project_root/smtp-server-template.plist)"
contents="${contents//__WORKING_DIRECTORY__/$project_root}"
contents="${contents//__PATH__//$PATH}"
plist_name="local.mail-server-dev"
plist_path="$HOME/Library/LaunchAgents/local.mail-server-dev.plist"

#first see if it's already loaded
if launchctl list | grep "$plist_name" >/dev/null 2>/dev/null; then
    # loaded, so try to stop it, and unload it
    launchctl stop "$plist_name"
    launchctl unload "$plist_path"
fi

echo "$contents" > "$plist_path"
launchctl load "$plist_path"
launchctl start "$plist_name"

$project_root/install-smtp-server-message.js
