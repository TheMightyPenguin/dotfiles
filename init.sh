# Install brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


# brew installs
brew install ripgrep
brew install neovim
brew install pyenv


# brew cask apps
brew cask install spotify
brew cask install slack
brew cask install keepingyouawake
brew cask install alfred
brew cask install scroll-reverser
brew cask install gitkraken
brew cask install postgres
brew cask install abstract


# install vim plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
