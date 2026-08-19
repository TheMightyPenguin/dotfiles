{ pkgs, lib, username, ... }:

{
  imports = [
    ./packages.nix
    ./zsh.nix
    ./git.nix
    ./tmux.nix
    ./starship.nix
    ./configs.nix
    ./darwin.nix
    ./linux.nix
  ];

  home = {
    inherit username;
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

    # Don't bump this without reading the home-manager release notes.
    stateVersion = "25.05";

    sessionVariables = {
      LANG = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      EDITOR = "nvim";
      VISUAL = "nvim";
      PAGER = "less";
      # Never let a token end up in ~/.zsh_history.
      HISTORY_IGNORE = "*token*";
      NEOVIDE_MULTIGRID = "1";
    };

    sessionPath = [
      "$HOME/bin"
      "$HOME/.local/bin"
    ];
  };

  # Let home-manager manage itself so `home-manager` is always on PATH.
  programs.home-manager.enable = true;

  # Nerd Font glyphs for starship / tmux / neovim. On macOS the fonts are
  # installed system-wide by nix-darwin instead (see modules/darwin).
  fonts.fontconfig.enable = lib.mkDefault pkgs.stdenv.isLinux;
}
