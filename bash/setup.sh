#!/bin/bash

# Useful setup functions

function log () {
    # A colored logger.
    # call: log "error message" "r" for a red output.
    # Third argument is label.
    col=""
    if [ $2 ]; then
        if [ "$2" == "r" ]
            then col="\033[0;31m"
        elif [ "$2" == "g" ]
            then col="\033[0;32m"
        elif [ "$2" == "c" ]
            then col="\033[0;36m"
        elif [ "$2" == "y" ]
            then col="\033[1;33m"
        fi
    fi
    printf "[\033[1;35m$3\033[0m]: $col$1\033[0m\n"
}

function caddyAni () {
    # Caddy animation during running  process.
    # Call with aptInstaller "arg" & caddy.
    local pid=$!
    declare -a ani=("   🛒" "  🛒 " " 🛒  " "🛒   " "     ")
    declare -i id
    id=0
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        id=$id%5
        #echo "$id ${ani[$id]}"
        printf "[\033[1;35m${ani[$id]}\033[0m]: $1\r"
        id=$((id+1))
        sleep .15
    done
}

function aptInstaller () {
    if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
        # 1: pkg name
        cmd="sudo apt install $1 -y"
        eval $cmd &> /dev/null & caddy "installing $1"
        sleep .1
        log "installed $1"
    else
        log "$1 installed already."
    fi
}

function snapInstaller () {
    # 1: pkg name
    if [ $(dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
        # 1: pkg name
        cmd="snap install $1"
        eval $cmd &> /dev/null & caddy "installing $1"
        sleep .1
        log "installed $1"
    else
        log "$1 installed already."
    fi
}