# shellcheck shell=bash

msg:info() {
    printf "\e[34mInfo:\e[0m %s\n" "$1"
}

msg:warning() {
    printf "\e[33mWarning:\e[0m %s\n" "$1" >&2
}

msg:error() {
    printf "\e[31mError:\e[0m %s\n" "$1" >&2
    exit 1
}