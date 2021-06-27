# Install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install rcm
brew install rcm

# Clone dotfiles
git clone git@github.com:TheMightyPenguin/dotfiles.git ~/.dotfiles

# Set up dotfiles with rc
cd ~/.dotfiles
RCRC=rcrc rcup
