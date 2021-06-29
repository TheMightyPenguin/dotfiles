export PATH=$HOME/bin:/usr/local/bin:$PATH

~/.local.sh

# Android Studio paths for react-native
# https://reactnative.dev/docs/environment-setup
if [[ `uname` == "Darwin" && -a /usr/libexec/java_home  ]]; then
  export ANDROID_HOME=$HOME/Library/Android/sdk
  export PATH=$PATH:$ANDROID_HOME/emulator
  export PATH=$PATH:$ANDROID_HOME/tools
  export PATH=$PATH:$ANDROID_HOME/tools/bin
  export PATH=$PATH:$ANDROID_HOME/platform-tools
  export JAVA_HOME="$(/usr/libexec/java_home)"
fi

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Start TMUX automatically
export ZSH_TMUX_AUTOSTART=true

# zplug
export ZPLUG_HOME=~/.zplug
source $ZPLUG_HOME/init.zsh

# theme
zplug "mafredri/zsh-async", from:github
zplug "sindresorhus/pure," use:pure.zsh, from:github, as:theme

# zplug plugins
zplug "plugins/common-aliases",    from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/colorize",          from:oh-my-zsh
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "plugins/copydir",           from:oh-my-zsh
zplug "plugins/copyfile",          from:oh-my-zsh
zplug "plugins/cp",                from:oh-my-zsh
zplug "plugins/dircycle",          from:oh-my-zsh
zplug "plugins/encode64",          from:oh-my-zsh
zplug "plugins/extract",           from:oh-my-zsh
zplug "plugins/history",           from:oh-my-zsh
zplug "plugins/tmux",              from:oh-my-zsh
zplug "plugins/urltools",          from:oh-my-zsh
zplug "plugins/web-search",        from:oh-my-zsh
zplug "plugins/asdf",        from:oh-my-zsh

# to move folders really fast (i.e.: `z frontend`)
zplug "plugins/z",                 from:oh-my-zsh

# use ctrl+z to switch from Vim to terminal, amazing one
zplug "plugins/fancy-ctrl-z",      from:oh-my-zsh

if [[ $OSTYPE = (darwin)* ]]; then
  zplug "lib/clipboard",         from:oh-my-zsh
  zplug "plugins/osx",           from:oh-my-zsh
  zplug "plugins/brew",          from:oh-my-zsh, if:"(( $+commands[brew] ))"
  zplug "plugins/macports",      from:oh-my-zsh, if:"(( $+commands[port] ))"
fi

zplug "plugins/node",              from:oh-my-zsh, if:"(( $+commands[node] ))"
zplug "plugins/npm",               from:oh-my-zsh, if:"(( $+commands[npm] ))"
zplug "plugins/pip",               from:oh-my-zsh, if:"(( $+commands[pip] ))"
zplug "plugins/sudo",              from:oh-my-zsh, if:"(( $+commands[sudo] ))"
zplug "plugins/gpg-agent",         from:oh-my-zsh, if:"(( $+commands[gpg-agent] ))"

ZSH_AUTOSUGGEST_STRATEGY=(history)

zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

export VISUAL=nvim
export EDITOR="$VISUAL"

alias zshconfig="nvim ~/.zshrc"

alias rawvim="vim -u ~/essentials.vim -n"

alias shelltimeperf="for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done"

# add bin to path
export PATH=$PATH:$HOME/bin

# yarn aliases to install global packages correctly
# alias yga='yarn global add --prefix `nodenv prefix`'
# alias ygr='yarn global remove --prefix `nodenv prefix`'

# yarn global path set
# yarn config set prefix `nodenv prefix` &> /dev/null

# pyenv stuff 🐍
# eval "$(pyenv init -)"
# alias pynstall='CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" pyenv install -v'

# To make rack fork work on Mojave
# @see: https://blog.phusion.nl/2017/10/13/why-ruby-app-servers-break-on-macos-high-sierra-and-what-can-be-done-about-it/
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# PostgreSQL bin path
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/10/bin

# bullet train theme stuff
BULLETTRAIN_CONTEXT_DEFAULT_USER="victor.tortolero"
BULLETTRAIN_DIR_EXTENDED=0
BULLETTRAIN_PROMPT_CHAR="$(echo $emoji[penguin]) "
BULLETTRAIN_TIME_SHOW=0
BULLETTRAIN_PROMPT_ORDER=(${BULLETTRAIN_PROMPT_ORDER:#(time)})
BULLETTRAIN_RUBY_PREFIX='💎'

# spaceship theme stuff
SPACESHIP_CHAR_SYMBOL="$(echo $emoji[penguin]) "
SPACESHIP_GIT_BRANCH_SHOW=false

# iPhone simulator
alias iosim='open -a Simulator'

alias emojilog='! git log --oneline --color | emojify | less -r'

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# GO stuff
# export PATH=$PATH:/usr/local/go/bin
# export PATH=$PATH:$(go env GOPATH)/bin
# export GOPATH=$(go env GOPATH)

current_dir() {
    echo "%{$terminfo[bold]$FG[228]%}%~%{$reset_color%}"
}

# # GIT Alias
# # Took from https://thoughtbot.com/upcase/videos/intro-to-dotfiles
function g {
    if [[ $# > 0 ]]; then
      git $@
    else
      git status
    fi
}

# # Complete go like git
compdef g=git

# Custom Prompt
# PROMPT="╭─[$(echo "%{$terminfo[bold]$FG[228]%}%~%{$reset_color%}")]
# ╰──➤$(echo $emoji[penguin]) "

alias crontab="VIM_CRONTAB=true crontab"

# Support hidden files with fzf
# https://github.com/junegunn/fzf/issues/337#issuecomment-343038847
export FZF_DEFAULT_COMMAND='rg --hidden -l ""'
export HOMEBREW_NO_AUTO_UPDATE=true

if ! zplug check; then
  zplug install
fi

zplug load

# share history!!
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
setopt share_history

# haskell
export PATH=$HOME/.cabal/bin:$PATH
export PATH=$HOME/.ghcup/bin:$PATH

# set yarn to use current node version
# # yarn config set prefix $(npm prefix -g) &> /dev/null

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/victor.tortolero/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/victor.tortolero/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/victor.tortolero/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/victor.tortolero/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

alias code=code-insiders

# asdf https://asdf-vm.com/#/core-manage-asdf-vm
# . $(brew --prefix asdf)/asdf.sh

# source ~/.local/bin/aws_zsh_completer.sh

# flutter
export PATH="$PATH:`pwd`/flutter/bin"

# terraform
autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform

alias vim='nvim'

# for rcm
# https://github.com/thoughtbot/rcm
export RCRC=rcrc

# setting bres installed ruby path on osx
if [[ `uname` == "Darwin"  ]]; then
    export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"
fi

clearfn () {clear;}
zle -N clearfn
bindkey "^;" clearfn

# fnm
export PATH=~/.fnm:$PATH
eval "$(fnm env)"

if [[ $OSTYPE = (linux)* ]]; then
    alias oni=/mnt/c/Program\ Files/Onivim2/Oni2.exe
fi

# Deno
export DENO_INSTALL=$HOME/.deno
export PATH=$DENO_INSTALL/bin:$PATH

# windows xserver thing
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

alias python=python2

alias cra='npx create-react-app --use-npm'

alias serve='npx http-server'

# keychain
for filename in "${keychain_add_files[@]}"; do
  keychain --nogui ~/.ssh/$filename
done
export HNAME=`hostname`
source $HOME/.keychain/$HNAME-sh

# 1password
function ops {
    eval $(op signin bstinson)
}


# brew
case `uname` in
  Darwin)
    eval "$(/opt/homebrew/bin/brew shellenv)"
  ;;
  Linux)
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
  ;;
esac
