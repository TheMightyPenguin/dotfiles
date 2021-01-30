# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

xcode-select --install

# taps
brew tap aws/tap
brew tap homebrew/cask-drivers


# brew installs
brew install ripgrep
brew install the_silver_searcher
brew install neovim
brew install pyenv
brew install zsh
brew install zplug
brew install tmux
brew install Schniz/tap/fnm
brew install fzf
brew install aws-sam-cli


# allow to install beta version of apps
brew tap homebrew/cask-versions


# brew cask apps
brew cask install spotify
brew cask install slack-beta
brew cask install keepingyouawake
brew cask install alfred
brew cask install scroll-reverser
brew cask install gitkraken
brew cask install postgres
brew cask install abstract
brew cask install iterm
brew cask install spectacle
brew cask install visual-studio-code-insiders
brew cask install zoomus
brew cask install discord
brew cask install keybase
brew cask install telegram-desktop
brew cask install postman
brew cask install xmind-zen
brew cask install grammarly
brew cask install iterm2
brew cask install docker
brew cask install vlc
brew cask install kitty
brew cask install google-chrome
brew cask install logitech-options


# install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

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
