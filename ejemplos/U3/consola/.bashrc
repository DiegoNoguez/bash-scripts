# Archivo de configuracion de main.sh

function salir () {
    exit 0
}

function cdl () {
    cd $1 && ls
}

function update() {
    sudo dnf update && sudo dnf upgrade
}

function pinfo () {
    bash ./bin/pinfo.sh $1
}