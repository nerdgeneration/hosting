# shellcheck shell=bash

# Checks if a port is used by another account
port:used() {
    local port="$1"
    cut -f2 /etc/hosting-accounts | grep -q "$port"
}

# Gets a random port number (500-996, 497 ports)
port:random() {
    echo "$(( ( RANDOM / 65 ) + 500 ))"
}

# Gets an available port number
port:find() {
    local port
    [[ "$(wc -l /etc/hosting-accounts)" -gt 496 ]] && msg:error "You have reached the account limit"
    port="$(port:random)"
    while port:used "$port"; do
        port="$(port:random)"
    done
    echo "$port"
}