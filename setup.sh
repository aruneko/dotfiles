#!/bin/sh

set -e
set -u

setup() {
  dotfiles=$home/.dotfiles

  # パッケージの存在確認
  has() {
    type "$1" > /dev/null 2>&1
  }

  symlink() {
    [ -e "$2" ] || ln -s "$1" "$2"
  }

  install_package() {
    if [ -e /etc/arch-release ]; then
      yaourt -S "$1"
    fi
  }

  # dotfilesのセットアップ
  if [-d "$dotfiles" ]; then
    (cd "$dotfiles" && git pull --rebase)
  else
    git clone https://github.com/aruneko/dotfiles "$dotfiles"
  fi

  # Zshのセットアップ
  if ! test has zsh; then
    intall_package "zsh zsh-completions zsh-syntax-highlighting"
  fi 
  symlink "$dotfiles/.zshrc" "$HOME/.zshrc"

  # Vimのセットアップ
  if ! test has vim; then
    install_package "vim"
  fi
  symlink "$dotfiles/.vimrc" "$HOME/.vimrc"
  symlink "$dotfiles/.vim"   "$HOME/.vim"

  # Fcitxのセットアップ
  if ! test has fcitx; then
    install_package "fcitx-mozc fcitx-im fcitx-configtool"
  fi

  # XMonadのセットアップ
  if ! test has xmonad; then
    install_package "xmonad xmonad-contrib xmobar xcompmgr dmenu2"
  fi
  symlink "$dotfiles/.xmonad" "$HOME/.xmonad"
}
