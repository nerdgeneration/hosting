#!/usr/bin/env bats

cd "/usr/lib/hosting" || {
    printf "\e[31mError:\e[0m %s\n" "This is not installed correctly. Cannot find '/usr/lib/hosting'..." >&2
    exit 1
}

source "lib/accounts.sh"
source "lib/msg.sh"
source "lib/nginx.sh"
source "lib/port.sh"
source "lib/route.sh"
source "lib/systemd.sh"


######### setup

@test "setup" {
    command -v nginx \
    && command -v certbot \
    && command -v php-fpm \
    && command -v docker \
    && grep -q certbot /etc/crontab \
    && grep -q '^hosting' /etc/group \
    && [ -f /etc/hosting ]
}


######### systemd

@test "systemd:add" {
    systemd:add "batsTest" "command"

    grep -q batsTest /etc/systemd/system/hosting-batsTest.service
}

@test "systemd:remove" {
    systemd:remove "batsTest"

    [[ ! -f /etc/systemd/system/hosting-batsTest.service ]] \
    && systemctl list-unit-files | grep -q batsTest
}