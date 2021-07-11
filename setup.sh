# logo
sleep .5;printf "\n\t\033[1;33mC O D E  \033[1;35mC A D D Y\033[0m\n\n";sleep .5

function log () {
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
    printf "[\033[1;33mCADDY\033[0m]: $col$1\033[0m\n"
}

function groove () {
    local pid=$!
    declare -a ani=("    🛒" "   🛒 " "  🛒  " " 🛒   " "🛒    " "      ")
    declare -i id
    id=0
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        id=$id%6
        #echo "$id ${ani[$id]}"
        printf "[\033[1;35m${ani[$id]}\033[0m]: $1\r"
        id=$((id+1))
        sleep .15
    done
}

function aptInstaller () {
    # 1: name 2: install command
    sudo apt -y install $1 &> /dev/null &
    groove "installing $1"
    wait
    log "installed $1"
}

aptInstaller "telegram-desktop"
aptInstaller "p7zip-full p7zip-rar"

# sleep 10 &
# groove "wait"

# # apt installations
# apts=(
#     "telegram-desktop"
#     "p7zip-full p7zip-rar"
# )
# log "starting apt installs" "y"
# for i in "${apts[@]}"
# do
#     echo test $i
#     installer "$i"
# done


# log "Hello World!" "c"