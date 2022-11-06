#!/usr/bin/env bash
set -e

function inst() {
  sudo dnf install -y $1
}

sudo echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
sudo echo "fastestmirror=True" >> /etc/dnf/dnf.conf

inst which
inst tldr
inst cheat

inst @development-tools
inst neovim

inst @base-x
inst xrandr
inst awesome

# install latest WezTerm
curl https://api.github.com/repos/wez/wezterm/releases/latest \
  | jq ".assets[].browser_download_url" \
  | grep fedora \
  | grep -E "\.rpm\"" \
  | sort -r \
  | head -1 \
  | xargs sudo dnf install -y 

inst firefox
