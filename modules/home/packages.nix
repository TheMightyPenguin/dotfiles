{ pkgs, lib, ... }:

{
  # Everything here resolves on both Darwin and Linux.
  # Platform-specific extras live in ./darwin.nix and ./linux.nix.
  #
  # Reconciled against `brew leaves` on the current machine. Formulae that are
  # deliberately *not* carried over: zplug (oh-my-zsh module replaces it),
  # rcm (this repo no longer uses rcup), pyenv (uv replaces it), pipx (uv tool),
  # starship / tmux / fzf / gh / lazygit / keychain (each has a home-manager
  # module that installs the binary and writes its config).
  home.packages = with pkgs; [
    # search / navigation
    ripgrep
    fd
    silver-searcher-ng # `ag` (the original was removed from nixpkgs: unmaintained since 2020)
    tree
    eza
    bat
    jq
    yq-go

    # editors & terminal multiplexers
    neovim
    zellij

    # git extras (gh / lazygit / git-lfs come from ./git.nix)
    diff-so-fancy
    delta

    # runtimes / toolchain managers (kept as managers, not pinned toolchains,
    # because projects pin their own versions)
    fnm # node
    uv # python (replaces pyenv: faster, and it also installs interpreters)
    rustup
    deno
    bun

    # containers — colima is the actual runtime on this machine; the docker
    # CLI and compose talk to it (and to Docker Desktop when that's running).
    colima
    docker-client
    docker-compose
    lima

    # media
    ffmpeg
    exiftool
    yt-dlp

    # misc
    wget
    curl
    unzip
    coreutils
    gnupg
    keychain
    _1password-cli # `op`
    terraform
  ]
  # On Linux fonts come from the user profile + fontconfig. On macOS
  # nix-darwin installs the very same derivations system-wide, so skip them
  # here to avoid two copies in ~/Library/Fonts.
  ++ lib.optionals pkgs.stdenv.hostPlatform.isLinux (import ../fonts.nix pkgs);
}
