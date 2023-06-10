{{ if eq .chezmoi.os "linux" -}}
#!/bin/bash
#
set -eufo pipefail

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt install curl wget -y
sudo apt-get dist-upgrade -y

sudo apt-get install -y\
    zathura \
    kitty \
    feh \
    curl \
    imagemagick \
    scrot \
    neofetch \
    vim \
    zsh \
    tmux \
    xinit \
    ripgrep \
    rofi \
    htop \
    xclip \
    i3lock \
    sxhkd \
    libpulse-dev \
    libxss-dev \
    libxcb-screensaver0-dev \
    pulseaudio \
    cargo \
    thermald \
    firmware-linux-nonfree \
    bspwm \
    picom \
    polybar \
    lm-sensors \
    xbacklight \
    gocryptfs \
    gocryptfs \
    fwupd \
    mpv \
    python3-pip \
    python3-venv \
    tor

{{ end -}}
