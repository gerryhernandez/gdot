#!/usr/bin/env bash
set -e

cd $HOME

sudo pacman -Syu --noconfirm

function inst() {
  shift
  sudo pacman -S --noconfirm "$@"
}

inst --needed base-devel

mkdir -p .srcApps
cd .srcApps
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
cd $HOME
paru -Syu --noconfirm

function insta () {
  shift
  paru -S --noconfirm "$@"
}

inst \
  acpi \
  adwaita-qt5 \
  alacritty \
  bc \
  discord \
  docker \
  firefox \
  flameshot \
  fzf \
  go \
  gopls \
  lua-language-server \
  luarocks \
  neovim \
  noto-fonts-emoji \
  pamixer \
  pipewire-pulse \
  pulsemixer \
  ripgrep \
  rofi \
  stylua \
  tldr \
  tmux \
  which \
  wireplumber \
  xclip \
  xdg-utils \
  xorg-xsetroot \
  yarn \
  zsh

insta firefox-pwa-bin \
  ulauncher \
  kmonad-bin \
  nvm

pushd /usr/share/fonts/TTF
sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
sudo wget https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete%20Mono.ttf
sudo fc-cache
popd

nvm install node
sudo luarocks install luacheck

pushd ~/.config
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git
popd
insta \
  cheat 

cd $HOME
mkdir -p src/github.com/gerryhernandez
pushd src/github.com/gerryhernandez
git clone https://github.com/gerryhernandez/dwm
cd dwm
git checkout main
sudo make install
popd

go install github.com/go-delve/delve/cmd/dlv@latest

sudo chsh -s $(which zsh) $USER

timedatectl set-timezone "$(curl --fail https://ipapi.co/timezone)"

# Dark theme for GTK4
gsettings set org.gnome.desktop.interface color-scheme prefer-dark

# Kmonad permissions
sudo groupadd uinput
sudo usermod -aG input $USER
sudo usermod -aG uinput $USER
sudo echo 'KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"' > 99-Kmonad.rules
sudo mv 99-Kmonad.rules /lib/udev/rules.d/99-Kmonad.rules

