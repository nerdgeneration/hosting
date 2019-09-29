# shellcheck shell=bash

nginx:add() {
    local hosting_name="$1"
    local domains="$*"
    
    sed -e "s/{{name}}/$hosting_name/g" \
        -e "s/{{domains}}/$domains/g" \
        "$HOSTING_ASSETS/nginx.conf" \
        >"/etc/nginx.d/hosting-$hosting_name.conf"
        
    nginx -t &>/dev/null || error "Configuration error with nginx. This requires manual intervention"
    certbot --nginx
    nginx -s reload
}

nginx:remove() {
    local hosting_name="$1"
    rm "/etc/nginx.d/hosting-$hosting_name.conf"
    nginx -s reload
}