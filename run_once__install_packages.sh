#!/bin/bash

set -o pipefail

sudo apt-get update -y

sudo apt-get install -y \
    software-properties-common \
    firmware-linux-nonfree \
    python3 \
    python3-pip \
    python3-setuptools \
    python3-pynvim \
    python3-venv \
    neofetch \
    zsh \
    ripgrep \
    thermald \
    tmux

{{- if eq .type "home" -}}

sudo apt-get install -y \
    zathura \
    feh \
    kitty \
    htop \
    imagemagick \
    scrot \
    xinit \
    rofi \
    xclip \
    i3lock \
    sxhkd \
    libpulse-dev \
    libxss-dev \
    libxcb-screensaver0-dev \
    pulseaudio \
    bspwm \
    picom \
    polybar \
    lm-sensors \
    xbacklight \
    gocryptfs \
    fwupd \
    mpv \
    tor

{{- end -}}


sudo apt-get upgrade -y

sudo chsh -s "$(which zsh)" "$(whoami)"


# nvim
if ! command -v nvim >/dev/null; then
    sudo apt install -y ninja-build gettext cmake unzip curl cmake build-essential git
    git clone -b release-0.9 https://github.com/neovim/neovim || true
    pushd neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    popd
fi

function setup_asdf() {
    asdf plugin add python || true
    asdf plugin add nodejs || true
    asdf plugin add rust || true
    asdf plugin add golang || true
    # run twice; nodejs will fail the first time due do an alias issue
    asdf install || asdf install
    pip install --upgrade pip
    npm install -g npm
}

# # asdf TODO
# if ! command -v asdf >/dev/null; then
#     sudo apt install -y curl git
#     git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch master || true
#     export PATH=$PATH:$HOME/.asdf/bin/
# fi
# setup_asdf
