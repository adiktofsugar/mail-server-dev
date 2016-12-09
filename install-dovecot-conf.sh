#!/bin/bash
set -eu -o pipefail
project_root="$(cd `dirname ${BASH_SOURCE[0]}`; pwd)"

now="$(date "+%s")"
conf_path="/usr/local/etc/dovecot"
backup_conf_path="$HOME/.mail-server-dev/dovecot-conf-backup-$now"

usage="
install-dovecot-conf.sh
 -h - this help
Installs dovecot conf to $conf_path, backs up existing to $backup_conf_path
"

while getopts ":h" opt; do
    case "$opt" in
        h) echo "$usage"; exit;;
    esac
done

password="mail-server-dev"
mbox_location="$HOME/.mail-server-dev/mboxes"
inbox_location="/var/mail/$USER"

# in local.conf...
# replace all tokens...
# __PASSWORD__       -> $password
# __MBOX_LOCATION__  -> $mbox_location
# __INBOX_LOCATION__ -> $inbox_location
# __USER__           -> $USER

mkdir -p "$HOME/.mail-server-dev"
cp -rf "$project_root/dovecot-conf" "$HOME/.mail-server-dev/dovecot-conf"
echo "" > "$HOME/.mail-server-dev/dovecot-conf/local.conf"
contents="$(cat "$project_root/dovecot-conf/local.conf")"
contents="${contents//__PASSWORD__/$password}"
contents="${contents//__MBOX_LOCATION__/$mbox_location}"
contents="${contents//__INBOX_LOCATION__/$inbox_location}"
contents="${contents//__USER__/$USER}"
echo "$contents" >> "$HOME/.mail-server-dev/dovecot-conf/local.conf"

if [[ -e "$conf_path/dovecot.conf" ]]; then
    # existing dovecot conf, backup then overwrite
    cp -rf "$conf_path" "$backup_conf_path"
    rm -rf "$conf_path"
fi
mv "$HOME/.mail-server-dev/dovecot-conf" "$conf_path"
