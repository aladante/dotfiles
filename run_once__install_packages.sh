#!/bin/bash

{{ if eq .chezmoi.os "linux" -}}

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
    ripgrep \
    cargo \
    zsh \
    thermald \
    git \
    tmux

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
    cargo \
    bspwm \
    picom \
    polybar \
    lm-sensors \
    xbacklight \
    gocryptfs \
    fwupd \
    mpv \
    tor

sudo apt-get upgrade -y

sudo chsh -s "$(which zsh)" "$(whoami)"

# nvim
if ! command -v nvim >/dev/null; then
    sudo apt install -y ninja-build gettext cmake unzip curl cmake build-essential
    git clone -b release-0.9 https://github.com/neovim/neovim || true
    pushd neovim
    make CMAKE_BUILD_TYPE=Release
    sudo make install
    popd
fi
# ripgrep
if ! command -v rg >/dev/null; then
    cargo install ripgrep
fi
{{ end -}}
