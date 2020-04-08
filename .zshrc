export PATH=$HOME/bin:/usr/local/bin:$PATH

export LANG=en_US.UTF-8

# Start TMUX automatically
export ZSH_TMUX_AUTOSTART=true

# zplug
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# theme
# zplug "bhilburn/powerlevel9k", use:powerlevel9k.zsh-theme

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

zplug "plugins/git",               from:oh-my-zsh, if:"(( $+commands[git] ))"
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
eval "$(pyenv init -)"
alias pynstall='CFLAGS="-I$(brew --prefix openssl)/include" LDFLAGS="-L$(brew --prefix openssl)/lib" pyenv install -v'

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
alias iosim='open /Applications/Xcode.app/Contents/Developer/Applications/Simulator.app'

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/victor.tortolero/.nodenv/versions/8.9.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/victor.tortolero/.nodenv/versions/8.9.3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/victor.tortolero/.nodenv/versions/8.9.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/victor.tortolero/.nodenv/versions/8.9.3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export PATH=/Users/victor.tortolero/.local/bin:/opt/local/bin:/opt/local/sbin:/Applications/Octave.app/Contents/Resources/usr/Cellar/octave/4.0.3/bin:$PATH

alias emojilog='! git log --oneline --color | emojify | less -r'

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/victor.tortolero/.nodenv/versions/11.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/victor.tortolero/.nodenv/versions/11.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# GO stuff
# export PATH=$PATH:/usr/local/go/bin
# export PATH=$PATH:$(go env GOPATH)/bin
# export GOPATH=$(go env GOPATH)

current_dir() {
    echo "%{$terminfo[bold]$FG[228]%}%~%{$reset_color%}"
}

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

# fnm
eval "$(fnm env --multi)"

# set yarn to use current node version
yarn config set prefix $(npm prefix -g) &> /dev/null

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/victor.tortolero/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/victor.tortolero/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/victor.tortolero/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/victor.tortolero/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true
[ -f "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env" ] && source "${GHCUP_INSTALL_BASE_PREFIX:=$HOME}/.ghcup/env"

# rbenv
eval "$(rbenv init -)"

fillbucket() {
  gsutil -m cp -r "gs://etl-dev-1b5b38d3-d2df-4da7-8a71-59cc3b2c7db0/raw_files/bhi/100_members/PROFESSIONAL_CLAIMS/" "gs://sftp-storage-alabama-bcbs-49b5-ysa9/alabama-bcbs/$1/PROFESSIONAL_CLAIMS"
  gsutil -m cp -r "gs://etl-dev-1b5b38d3-d2df-4da7-8a71-59cc3b2c7db0/raw_files/bhi/100_members/FACILITY_CLAIM_DETAIL/" "gs://sftp-storage-alabama-bcbs-49b5-ysa9/alabama-bcbs/$1/FACILITY_CLAIM_DETAIL"
  gsutil -m cp -r "gs://etl-dev-1b5b38d3-d2df-4da7-8a71-59cc3b2c7db0/raw_files/bhi/100_members/FACILITY_CLAIM_HEADER/" "gs://sftp-storage-alabama-bcbs-49b5-ysa9/alabama-bcbs/$1/FACILITY_CLAIM_HEADER"
  gsutil -m cp -r "gs://etl-dev-1b5b38d3-d2df-4da7-8a71-59cc3b2c7db0/raw_files/bhi/100_members/MEMBER/" "gs://sftp-storage-alabama-bcbs-49b5-ysa9/alabama-bcbs/$1/MEMBER"
  gsutil -m cp -r "gs://etl-dev-1b5b38d3-d2df-4da7-8a71-59cc3b2c7db0/raw_files/bhi/100_members/PHARMACY_CLAIMS/" "gs://sftp-storage-alabama-bcbs-49b5-ysa9/alabama-bcbs/$1/PHARMACY_CLAIMS"
  gsutil -m cp -r "gs://etl-dev-1b5b38d3-d2df-4da7-8a71-59cc3b2c7db0/raw_files/bhi/100_members/MEMBER_ENROLLMENT/" "gs://sftp-storage-alabama-bcbs-49b5-ysa9/alabama-bcbs/$1/MEMBER_ENROLLMENT"
}

alias code='code-insiders'

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"
