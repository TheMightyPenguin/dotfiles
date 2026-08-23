#!/bin/bash

# Install fnm
# https://github.com/Schniz/fnm
curl -fsSL https://fnm.vercel.app/install | bash -s -- --skip-shell

# brew installs
brew install ripgrep
brew install the_silver_searcher
brew install neovim
brew install pyenv
brew install zsh
brew install zplug
brew install tmux
brew install fzf
brew install fd
brew install keychain
brew install gh
brew install jesseduffield/lazygit/lazygit
brew install starship
brew install ffmpeg
brew install exiftool

# allow to install beta version of apps
brew tap homebrew/cask-versions

# brew cask apps
brew install --cask 1password/tap/1password-cli
brew install --cask rectangle
brew install --cask spotify
brew install --cask karabiner-elements
brew install --cask keepingyouawake
brew install --cask raycast
brew install --cask choosy
brew install --cask scroll-reverser
brew install --cask visual-studio-code
brew install --cask visual-studio-code@insiders
brew install --cask discord
brew install --cask telegram-desktop
brew install --cask docker
brew install --cask kitty
brew install --cask wezterm
brew install --cask google-chrome
brew install --cask logitech-options
brew install --cask notion

brew install --cask font-symbols-only-nerd-font

# install zplug
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# wsl specific
if [[ $(uname) == "Linux" ]]; then
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
fnm install v22.9.0
fnm default v22.9.0
corepack enable
corepack prepare pnpm@latest --activate
# this does not work for yarn, figure out why?
# corepack prepare yarn@latest --activate

# Local config files from 1p
op get item .local.sh --fields notes >.local.sh

# install rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

echo "Done initializing 🐧"
