# shellcheck shell=bash

accounts:init() {
    [[ ! -d /etc/hosting-accounts ]] && touch /etc/hosting-accounts
}

accounts:add() {
    useradd \
        --comment "Hosting/$HOSTING_VERSION $(date +"%Y-%m-%d %H:%M:%S")" \
        --skel "$HOSTING_ASSETS/skel" \
        --create-home \
        --gid "hosting" \
        --shell "/bin/bash" \
        "$hosting_name"

}

accounts:remove() {
    local hosting_name="$1"
    sed --in-place "/^$hosting_name\t/;d" /etc/hosting-accounts
}