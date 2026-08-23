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

    # tools that used to come from third-party Homebrew taps. Every one of
    # these is in nixpkgs, so the taps (and Homebrew's trust prompt for them)
    # are unnecessary — see the note in modules/darwin/homebrew.nix.
    crush # was charmbracelet/tap
    codecrafters-cli # was codecrafters-io/tap
    sqld # was libsql/sqld
    turso # was tursodatabase/tap

    # GUI apps that are safe to take from nixpkgs: none of them need an
    # Accessibility / Input Monitoring grant and none install a privileged
    # daemon, so the two things that break nix-installed Mac apps don't apply.
    # mac-app-util (see flake.nix) makes them findable in Spotlight/Raycast.
    # Everything else stays a Homebrew cask — see modules/darwin/homebrew.nix.
  ]
  ++ lib.optionals pkgs.stdenv.hostPlatform.isDarwin [
    obsidian
    discord
    spotify
    notion-app
  ]
  ++ [

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
