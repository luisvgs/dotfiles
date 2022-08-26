#!/bin/bash

if ! command -v zsh &> /dev/null
then
    echo '[!] zsh not found as shell. Installing now...'
    pacman -S zsh
fi

echo '[*] zsh was installed. Configuring as default shell now...'
sudo chsh -s $(which zsh) "$USER"
echo '[*] Done.'


if ! command -v neovim &> /dev/null
then
    echo '[!] neovim not installed. Installing now...'
    pacman -S neovim

    echo '[*] Done. '

    echo '[!] Configuring packer...'
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    echo '[*] Done. '

    echo '[!] Creating editor config directory'
    mkdir $HOME/.config/nvim -p
    echo '[*] Done. '
fi

if ! [-x "$(command -v rustup)"]; then
    echo '[!] Rust is not installed. Installing now...'
    pacman -S rustup
    echo '[*] Done. '
fi

if ! command -v tig &> /dev/null
then
    echo '[!] Tig not installed. Installing now...'
    echo '[*] Done. '
    pacman -S tig
fi

if ! command -v npm &> /dev/null
then
    echo '[!] NPM not installed. Installing now...'
    echo '[*] Done. '
    # TODO: configure /.npm_global for later.
    pacman -S npm
fi

# if ! [-x "$(command -v yay)"]; then
#     echo 'NPM not installed. Installing now...'
