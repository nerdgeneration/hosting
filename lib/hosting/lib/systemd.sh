# shellcheck shell=bash

systemd:add() {
    sed -e "s/{{name}}/$hosting_name/g" \
        -e "s/{{command}}/$command/g" \
        "$HOSTING_ASSETS/systemd.service" \
        >"/etc/systemd/system/hosting-$hosting_name.service"
    systemctl daemon-reload
    systemctl enable "hosting-$hosting_name.service"
    systemctl start "hosting-$hosting_name.service"
}

systemd:remove() {
    systemctl stop "hosting-$hosting_name.service" || msg:warning "Could not stop '$hosting_name', continuing regardless"
    systemctl disable "hosting-$hosting_name.service"
    rm "/etc/systemd/system/hosting-$hosting_name.service"
    systemctl daemon-reload
}