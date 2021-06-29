#!/bin/bash

# Install fnm
# https://github.com/Schniz/fnm
curl -fsSL https://fnm.vercel.app/install | bash -s --  --skip-shell

# taps
brew tap aws/tap
brew tap homebrew/cask-drivers


# brew installs
brew install ripgrep
brew install the_silver_searcher
brew install --HEAD luajit
brew install --HEAD neovim
brew install pyenv
brew install zsh
brew install zplug
brew install tmux
brew install fzf
brew install keychain


# allow to install beta version of apps
brew tap homebrew/cask-versions


# brew cask apps
brew install --cask rectangle
brew install --cask spotify
brew install --cask slack-beta
brew install --cask keepingyouawake
brew install --cask alfred
brew install --cask scroll-reverser
brew install --cask iterm
brew install --cask visual-studio-code-insiders
brew install --cask discord
brew install --cask telegram-desktop
brew install --cask postman
brew install --cask iterm2
brew install --cask docker
brew install --cask kitty
brew install --cask google-chrome
brew install --cask logitech-options


# install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim


# install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh


# wsl specific
if [[ `uname` == "Linux"   ]]; then
    if grep -q microsoft /proc/version; then
        ## Download win32yank
        wget https://github.com/equalsraf/win32yank/releases/download/v0.0.4/win32yank-x64.zip
        unzip win32yank-x64.zip
        rm -rf README.md
        rm -rf LICENSE
        mv win32yank.exe ~/bin
    fi
fi


# Node
fnm install 14.16.1
fnm default 14.16.1


# Local config files from 1p
op get item .local.sh --fields notes > .local.sh
