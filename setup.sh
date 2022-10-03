#!/bin/bash

# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install rcm
eval "$(/opt/homebrew/bin/brew shellenv)"
brew install rcm

# Clone dotfiles
git clone https://github.com/TheMightyPenguin/dotfiles.git ~/.dotfiles

# Set up dotfiles with rc
cd ~/.dotfiles
RCRC=rcrc rcup

./init.sh
