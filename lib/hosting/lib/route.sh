# shellcheck shell=bash

route:setup() {
    # Install the EPEL and Remi repositories...
    yum install --assumeyes https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
    yum install --assumeyes https://rpms.remirepo.net/enterprise/remi-release-7.rpm

    # ... but manually configure the Remi PHP
    install --owner=root --group=root --mode=u=rw,go=r assets/hosting.repo /etc/yum.repos.d/hosting.repo

    # Amazon provides it's own docker setup
    amazon-linux-extras install docker

    # Install nginx, Let's Encrypt and PHP FastCGI (+common packages)
    yum install --assumeyes nginx certbot php-fpm php-xml php-xmlrpc php-phar php-pdo php-mysqlnd php-openssl php-mbstring php-intl

    # Configure certbot to update SSL certificates twice a day (this is their code)
    echo "0 0,12 * * * root python -c 'import random; import time; time.sleep(random.random() * 3600)' && certbot renew" \
        >>/etc/crontab

    # Other system setup
    groupadd hosting
    touch /etc/hosting
}

route:add() {
    local hosting_name="$1"
    local hosting_type="$2"
    local domains=("$@")
    local base="/home/$hosting_name"

    grep -q "^$hosting_name:" /etc/passwd && msg:error "System user '$hosting_name' already exists"
    [[ -d "$base" ]] && msg:error "Account '$hosting_name' already exists"
    [[ "$hosting_type" =~ static|php|node|docker ]] && msg:error "Invalid hosting type: $hosting_type"

    printf "hosting_name=%s\nhosting_type=%s\n" "$hosting_name" "$hosting_type" >"$base/.hosting"
    chown root:root "$base/.hosting"
    chmod u=rw,go= "$base/.hosting"

    case "$hosting_type" in
        "static")
            ;;
        "php")
            ;;
        "node")
            ;;
        "docker")
            ;;
        *)
            msg:error "Invalid hosting type: $hosting_type"
            ;;
    esac
}

route:del() {
    local hosting_name="$1"
    local base="/home/$hosting_name"

    [[ ! -f "$base/.hosting" ]] && msg:error "'$hosting_name' is not a hosting account"
    # shellcheck source=/dev/null
    source "$base/.hosting" # TODO Parse the file instead

    systemctl stop "hosting-$hosting_name.service"
    systemctl disable "hosting-$hosting_name.service"
    rm "/etc/nginx.d/hosting-$hosting_name.conf" 2>/dev/null || msg:warning "Could not remove /etc/nginx.d/hosting-$hosting_name.conf"
    # TODO Remove systemd unit file
    # TODO Remove LetsEncrypt certificate
    userdel --force --remove "$hosting_name"
}