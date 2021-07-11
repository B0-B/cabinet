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
    printf "[\033[1;35mCADDY\033[0m]: $col$1\033[0m\n"
}

function caddy () {
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
    # 1: pkg name
    cmd="sudo apt install $1 -y"
    eval $cmd &> /dev/null & caddy "installing $1"
    sleep .1
    log "installed $1"
}

function snapInstaller () {
    # 1: pkg name
    cmd="snap install $1 --classic"
    eval $cmd &> /dev/null & caddy "installing $1"
    log "installed $1"
}

# -- apt package install --
log "installing apt packages" "y"
aptInstaller p7zip-full 
aptInstaller p7zip-rar
aptInstaller telegram-desktop
aptInstaller snap
aptInstaller curl 

# -- snap package install --
log "installing snap packages" "y"
snapInstaller code 

# install distro
log "setup distro" "y"

# change background
wallpaperDir=$HOME/wallpaper/
[ -d $wallpaperDir ] && log "Directory $wallpaperDir exists already." || mkdir $wallpaperDir && 
curl https://cdn.pling.com/img/5/6/4/6/61892171f7d21851565aca04d73234557d24.png --output ubuntu.png &> /dev/null &&
mv ubuntu.png $wallpaperDir/ubuntu.png &&
gsettings set org.gnome.desktop.background picture-uri $wallpaperDir/ubuntu.png && log "wallpaper was set."

