{ pkgs, lib, ... }:

{
  # Everything here resolves on both Darwin and Linux.
  # Platform-specific extras live in ./darwin.nix and ./linux.nix.
  home.packages = with pkgs; [
    # search / navigation
    ripgrep
    fd
    silver-searcher # `ag`
    tree
    eza
    bat
    jq
    yq-go

    # editors & terminal multiplexers
    neovim
    zellij

    # git (gh / lazygit / git-lfs come from their modules in ./git.nix)
    diff-so-fancy
    delta

    # runtimes / toolchain managers (kept as managers, not pinned toolchains,
    # because projects pin their own versions)
    fnm # node
    uv # python (replaces pyenv: faster, and it also installs interpreters)
    rustup
    deno
    bun

    # misc
    ffmpeg
    exiftool
    wget
    curl
    unzip
    coreutils
    keychain
    _1password-cli # `op`
    terraform
  ]
  # On Linux fonts come from the user profile + fontconfig. On macOS
  # nix-darwin installs the very same derivations system-wide, so skip them
  # here to avoid two copies in ~/Library/Fonts.
  ++ lib.optionals pkgs.stdenv.isLinux (import ../fonts.nix pkgs);
}
