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
zplug "plugins/z",                 from:oh-my-zsh
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

if zplug check "bhilburn/powerlevel9k"; then
  # Easily switch primary foreground/background colors
  DEFAULT_FOREGROUND=006 DEFAULT_BACKGROUND=235
  DEFAULT_COLOR=$DEFAULT_FOREGROUND

  # powerlevel9k prompt theme
  #DEFAULT_USER=$USER

  POWERLEVEL9K_MODE="nerdfont-complete"
  POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
  #POWERLEVEL9K_SHORTEN_STRATEGY="truncate_right"

  POWERLEVEL9K_DIR_OMIT_FIRST_CHARACTER=false

  POWERLEVEL9K_ALWAYS_SHOW_CONTEXT=true
  POWERLEVEL9K_ALWAYS_SHOW_USER=false

  POWERLEVEL9K_CONTEXT_TEMPLATE="\uF109 %m"

  POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND="$DEFAULT_BACKGROUND"

  POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR="\uE0B4"
  POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"
  POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR="\uE0B6"
  POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR="%F{$(( $DEFAULT_BACKGROUND - 2 ))}|%f"

  POWERLEVEL9K_PROMPT_ON_NEWLINE=true
  POWERLEVEL9K_RPROMPT_ON_NEWLINE=false

  POWERLEVEL9K_STATUS_VERBOSE=true
  POWERLEVEL9K_STATUS_CROSS=true
  POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  #POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{cyan}\u256D\u2500%f"
  #POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{014}\u2570%F{cyan}\uF460%F{073}\uF460%F{109}\uF460%f "
  #POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭─%f"
  #POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰─%F{008}\uF460 %f"
  #POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX=""
  #POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{008}> %f"

  POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="╭"
  #POWERLEVEL9K_MULTILINE_SECOND_PROMPT_PREFIX="❱ "
  POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="╰\uF460 "

  #POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh root_indicator dir_writable dir )
  #POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon root_indicator context dir_writable dir vcs)
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(root_indicator context dir_writable dir vcs)
  POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time background_jobs status time ssh)

  POWERLEVEL9K_VCS_CLEAN_BACKGROUND="green"
  POWERLEVEL9K_VCS_CLEAN_FOREGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_VCS_MODIFIED_BACKGROUND="yellow"
  POWERLEVEL9K_VCS_MODIFIED_FOREGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND="magenta"
  POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND="$DEFAULT_BACKGROUND"

  POWERLEVEL9K_DIR_HOME_BACKGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_DIR_HOME_FOREGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_DIR_DEFAULT_BACKGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_DIR_DEFAULT_FOREGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_BACKGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND="$DEFAULT_BACKGROUND"

  POWERLEVEL9K_STATUS_OK_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_STATUS_OK_FOREGROUND="green"
  POWERLEVEL9K_STATUS_OK_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_STATUS_OK_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"

  POWERLEVEL9K_STATUS_ERROR_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_STATUS_ERROR_FOREGROUND="red"
  POWERLEVEL9K_STATUS_ERROR_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_STATUS_ERROR_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"

  POWERLEVEL9K_HISTORY_FOREGROUND="$DEFAULT_FOREGROUND"

  POWERLEVEL9K_TIME_FORMAT="%D{%T \uF017}" #  15:29:33
  POWERLEVEL9K_TIME_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_TIME_BACKGROUND="$DEFAULT_BACKGROUND"

  POWERLEVEL9K_VCS_GIT_GITHUB_ICON=""
  POWERLEVEL9K_VCS_GIT_BITBUCKET_ICON=""
  POWERLEVEL9K_VCS_GIT_GITLAB_ICON=""
  POWERLEVEL9K_VCS_GIT_ICON=""

  POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_EXECUTION_TIME_ICON="\u23F1"

  #POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
  #POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0

  POWERLEVEL9K_BACKGROUND_JOBS_FOREGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_BACKGROUND_JOBS_BACKGROUND="$DEFAULT_FOREGROUND"

  POWERLEVEL9K_USER_ICON="\uF415" # 
  POWERLEVEL9K_USER_DEFAULT_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_USER_DEFAULT_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_USER_ROOT_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_USER_ROOT_BACKGROUND="$DEFAULT_BACKGROUND"

  POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="magenta"
  POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"
  POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
  #POWERLEVEL9K_ROOT_ICON=$'\uFF03' # ＃
  POWERLEVEL9K_ROOT_ICON=$'\uF198'  # 

  POWERLEVEL9K_SSH_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_SSH_FOREGROUND="yellow"
  POWERLEVEL9K_SSH_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_SSH_BACKGROUND="$(( $DEFAULT_BACKGROUND + 2 ))"
  POWERLEVEL9K_SSH_BACKGROUND="$(( $DEFAULT_BACKGROUND - 2 ))"
  POWERLEVEL9K_SSH_ICON="\uF489"  # 

  POWERLEVEL9K_HOST_LOCAL_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_HOST_LOCAL_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_HOST_REMOTE_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_HOST_REMOTE_BACKGROUND="$DEFAULT_BACKGROUND"

  POWERLEVEL9K_HOST_ICON_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_HOST_ICON_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_HOST_ICON="\uF109" # 

  POWERLEVEL9K_OS_ICON_FOREGROUND="$DEFAULT_FOREGROUND"
  POWERLEVEL9K_OS_ICON_BACKGROUND="$DEFAULT_BACKGROUND"

  POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_LOAD_WARNING_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_LOAD_NORMAL_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND="red"
  POWERLEVEL9K_LOAD_WARNING_FOREGROUND="yellow"
  POWERLEVEL9K_LOAD_NORMAL_FOREGROUND="green"
  POWERLEVEL9K_LOAD_CRITICAL_VISUAL_IDENTIFIER_COLOR="red"
  POWERLEVEL9K_LOAD_WARNING_VISUAL_IDENTIFIER_COLOR="yellow"
  POWERLEVEL9K_LOAD_NORMAL_VISUAL_IDENTIFIER_COLOR="green"

  POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND_COLOR="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_BATTERY_CHARGING_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_BATTERY_CHARGED_BACKGROUND="$DEFAULT_BACKGROUND"
  POWERLEVEL9K_BATTERY_DISCONNECTED_BACKGROUND="$DEFAULT_BACKGROUND"

  POWERLEVEL9K_PYENV_PROMPT_ALWAYS_SHOW=true
fi

# Path to your oh-my-zsh installation.
# export ZSH=/Users/victor.tortolero/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="spaceship"
# ZSH_THEME="bullet-train"
# ZSH_THEME="robbyrussell"

bindkey "[D" backward-word
bindkey "[C" forward-word
# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export VISUAL=nvim
export EDITOR="$VISUAL"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

alias zshconfig="nvim ~/.zshrc"
# alias ohmyzsh="code ~/.oh-my-zsh"

# add bin to path
export PATH=$PATH:$HOME/bin

# yarn aliases to install global packages correctly
# alias yga='yarn global add --prefix `nodenv prefix`'
# alias ygr='yarn global remove --prefix `nodenv prefix`'

# yarn global path set
# yarn config set prefix `nodenv prefix` &> /dev/null

# pyenv stuff 🐍
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
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

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/victor.tortolero/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/victor.tortolero/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/victor.tortolero/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/victor.tortolero/google-cloud-sdk/completion.zsh.inc'; fi

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/victor.tortolero/.nodenv/versions/11.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/victor.tortolero/.nodenv/versions/11.6.0/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
