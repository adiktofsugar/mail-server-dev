#!/bin/bash
set -eu -o pipefail
project_root="$(cd `dirname ${BASH_SOURCE[0]}`; pwd)"

usage="
install.sh
 -h - this help
Installs dovecot and the configuration for it.
Your current user, $USER, will be used for everything
Installs the fake smtp server at port 1025, which sends everything to $USER@localhost
"

while getopts ":h" opt; do
    case "$opt" in
        h) echo "$usage"; exit;;
    esac
done

$project_root/install-dovecot.sh
$project_root/install-smtp-server.sh
