#!/bin/sh

set -e
set -u

setup() {
  dotfiles=$HOME/.dotfiles

  # パッケージの存在確認
  has() {
    type "$1" > /dev/null 2>&1
  }

  symlink() {
    [ -e "$2" ] || ln -s "$1" "$2"
  }

  install_package() {
    if [ -e /etc/arch-release ]; then
      yaourt -S $* 
    fi
  }

  # dotfilesのセットアップ
  if [ -d "$dotfiles" ]; then
    (cd "$dotfiles" && git pull --rebase)
  else
    git clone https://github.com/aruneko/dotfiles "$dotfiles"
  fi

  # Zshのセットアップ
  if ! has zsh; then
    install_package zsh zsh-completions zsh-syntax-highlighting
  fi 
  symlink "$dotfiles/.zshrc" "$HOME/.zshrc"

  # Vimのセットアップ
  if ! has vim; then
    install_package vim
  fi
  symlink "$dotfiles/.vimrc" "$HOME/.vimrc"
  symlink "$dotfiles/.vim"   "$HOME/.vim"

  # Fcitxのセットアップ
  if ! test (has fcitx); then
    install_package fcitx-mozc fcitx-im fcitx-configtool
  fi

  # Qtileのセットアップ
  if ! has xmonad; then
    install_package qtile xcompmgr dmenu2 stalonetray nitrogen archlinux-wallpaper 
  fi
  symlink "$dotfiles/qtile" "$HOME/.config/qtile"
}

setup
