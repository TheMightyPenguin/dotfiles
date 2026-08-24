{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;

    # home-manager will move this to $XDG_CONFIG_HOME/zsh at stateVersion
    # 26.05. Pin the current location so a stateVersion bump doesn't silently
    # relocate ~/.zshrc and orphan the history file.
    dotDir = config.home.homeDirectory;

    autosuggestion = {
      enable = true;
      strategy = [ "history" ];
    };
    syntaxHighlighting.enable = true;
    enableCompletion = true;

    history = {
      path = "${config.home.homeDirectory}/.zsh_history";
      size = 10000;
      save = 10000;
      append = true;
      share = true;
      ignoreAllDups = true;
      # Belt and braces alongside HISTORY_IGNORE.
      ignorePatterns = [
        "*token*"
        "*secret*"
        "*password*"
      ];
    };

    # Replaces zplug. Same plugin list as before, minus the ones that now have
    # a first-class module (`z` -> zoxide, `fzf`, `tmux`, and brew/node/npm/pip
    # completions, which come from the nix-installed packages themselves).
    oh-my-zsh = {
      enable = true;
      plugins = [
        "colored-man-pages"
        "colorize"
        "command-not-found"
        "common-aliases"
        "copyfile"
        "copypath"
        "cp"
        "dircycle"
        "encode64"
        "extract"
        "fancy-ctrl-z" # ctrl+z back and forth between nvim and the shell
        "gpg-agent"
        "history"
        "sudo"
        "urltools"
        "web-search"
      ]
      ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [ "macos" ];
    };

    shellAliases = {
      vim = "nvim";
      v = "nvim";
      zshconfig = "nvim ${config.dotfiles.directory}";

      # git
      gs = "git status";
      emojilog = "git log --oneline --color | emojify | less -r";

      # ls -> eza (defined here rather than via programs.eza, whose own
      # integration would collide with these definitions)
      ls = "eza --icons --group-directories-first";
      ll = "eza -l --icons --group-directories-first --git";
      la = "eza -la --icons --group-directories-first --git";
      lt = "eza --tree --level=2 --icons";

      # js/ts
      p = "pnpm";
      cra = "npx create-react-app --use-npm";
      serve = "npx http-server";
      nworker = "pnpm create cloudflare@latest";

      tf = "terraform";
      crontab = "VIM_CRONTAB=true crontab";
      mongod = "mongod --dbpath=$HOME/data/db";

      # claude code, permission prompts off
      cc = "claude --dangerously-skip-permissions";

      shelltimeperf = "for i in $(seq 1 10); do /usr/bin/time $SHELL -i -c exit; done";

      # nix
      hm = "home-manager";
      switch = "make -C ${config.dotfiles.directory} switch";
    };

    initContent = lib.mkMerge [
      # Runs before oh-my-zsh / plugin init.
      (lib.mkOrder 550 ''
        # Support hidden files with fzf
        # https://github.com/junegunn/fzf/issues/337#issuecomment-343038847
        export FZF_DEFAULT_COMMAND='rg --hidden --files'

        # brew's own auto-update on every invocation is slow and, now that nix
        # owns the package list, redundant — `make switch` updates the casks.
        export HOMEBREW_NO_AUTO_UPDATE=true
      '')

      (lib.mkAfter ''
        # Took from https://thoughtbot.com/upcase/videos/intro-to-dotfiles
        # `g` with no args is `git status`, otherwise it forwards to git.
        function g {
          if [[ $# -gt 0 ]]; then
            git "$@"
          else
            git status
          fi
        }
        compdef g=git

        # corepack: turn on pnpm for the fnm-managed node currently in use.
        # Has to be re-run per node version, hence a function rather than
        # something declared once at build time.
        function corepenable {
          corepack enable
          corepack prepare pnpm@latest --activate
        }

        # ctrl+; to clear the screen
        clearfn() { clear; }
        zle -N clearfn
        bindkey "^;" clearfn

        # node: use the version in .node-version / .nvmrc when cd-ing around
        if (( $+commands[fnm] )); then
          eval "$(fnm env --use-on-cd --shell zsh)"
        fi

        # scratch projects — https://github.com/tobi/try
        if (( $+commands[try] )); then
          eval "$(try init ~/src/tries)"
        fi

        # Machine-local, never-committed overrides (tokens, work stuff).
        # Populate with: op read "op://Private/.local.sh/notesPlain" > ~/.local.sh
        [[ -f ~/.local.sh ]] && source ~/.local.sh
      '')
    ];
  };

  # `z frontend` still works — this is the oh-my-zsh `z` plugin's replacement,
  # and unlike it, it's the same binary on macOS and Linux.
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd z" ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  # Per-project envs without polluting ~/.zshrc.
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };

  # Replaces the hand-rolled keychain loop at the bottom of the old zshrc.
  programs.keychain = {
    enable = true;
    enableZshIntegration = true;
    keys = [ "github" ];
    extraFlags = [
      "--quiet"
      "--nogui"
    ];
  };

  programs.ssh = {
    enable = true;
    # Opt out of home-manager's implicit `Host *` block so the only global
    # defaults are the ones set below.
    enableDefaultConfig = false;

    # colima rewrites its own host entry here whenever a VM is created;
    # including the file keeps `ssh colima` and the docker context working
    # without hand-editing ~/.ssh/config, which home-manager now owns.
    includes = [ "${config.home.homeDirectory}/.colima/ssh_config" ];

    # `settings` replaced `matchBlocks`; keys are ssh_config(5) directives
    # verbatim, and it's a DAG so the catch-all can be pinned last — ssh takes
    # the *first* value it sees for an option, so a leading `Host *` would
    # shadow everything after it.
    settings = {
      "github.com" = {
        # Port 443 so git works from behind restrictive networks.
        HostName = "ssh.github.com";
        Port = 443;
        User = "git";
      };

      "*" = lib.hm.dag.entryAfter [ "github.com" ] {
        AddKeysToAgent = "yes";
      };
    };
  };
}
