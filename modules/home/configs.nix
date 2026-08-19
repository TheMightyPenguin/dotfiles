{ config, lib, pkgs, ... }:

let
  cfg = config.dotfiles;

  # `mkOutOfStoreSymlink` points ~/.config/nvim at the *working copy* in this
  # repo instead of a read-only /nix/store path. That keeps the LazyVim /
  # wezterm / kitty edit-and-reload loop intact: change a file, see it live,
  # no `switch` needed. Configs whose format Nix models well (zsh, git, tmux,
  # starship) are generated instead — see the sibling modules.
  link = path: config.lib.file.mkOutOfStoreSymlink "${cfg.directory}/${path}";
in
{
  options.dotfiles.directory = lib.mkOption {
    type = lib.types.str;
    default = "${config.home.homeDirectory}/.dotfiles";
    description = ''
      Absolute path to this repository's checkout on the target machine.
      Config directories that stay as native files are symlinked from here.
    '';
  };

  config = {
    xdg.enable = true;

    xdg.configFile = {
      "nvim".source = link "config/nvim";
      "wezterm".source = link "config/wezterm";
      "zellij".source = link "config/zellij";
      "kitty".source = link "config/kitty";
    };

    # Neovim itself, plus the external tools LazyVim shells out to. The plugins
    # stay under lazy.nvim's management (lazy-lock.json is the lockfile) —
    # nix only guarantees the binaries they need are present.
    home.packages = with pkgs; [
      # LSP/format/lint toolchain LazyVim's extras expect
      lua-language-server
      stylua
      typescript-language-server
      vscode-langservers-extracted # html/css/json/eslint
      tailwindcss-language-server
      marksman
      taplo # toml
      pyright
      black
      prettier

      # nvim-treesitter compiles parsers at runtime and needs a compiler:
      # clang on Darwin, gcc on Linux — stdenv.cc picks the right one.
      stdenv.cc
      gnumake
      tree-sitter
    ];
  };
}
