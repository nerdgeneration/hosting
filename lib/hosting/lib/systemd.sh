# shellcheck shell=bash

systemd:add() {
    local hosting_name="$1"
    local command="$2"

    sed -e "s/{{name}}/$hosting_name/g" \
        -e "s/{{command}}/$command/g" \
        "assets/systemd.service" \
        >"/etc/systemd/system/hosting-$hosting_name.service"
    systemctl daemon-reload
    systemctl enable "hosting-$hosting_name.service"
    systemctl start "hosting-$hosting_name.service"
}

systemd:remove() {
    local hosting_name="$1"

    systemctl stop "hosting-$hosting_name.service" || msg:warning "Could not stop '$hosting_name', continuing regardless"
    systemctl disable "hosting-$hosting_name.service"
    rm "/etc/systemd/system/hosting-$hosting_name.service"
    systemctl daemon-reload
}