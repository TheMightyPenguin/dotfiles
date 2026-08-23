{ config, lib, pkgs, ... }:

let
  cfg = config.dotfiles;

  # `mkOutOfStoreSymlink` points ~/.config/nvim at the *working copy* in this
  # repo instead of a read-only /nix/store path. That keeps the nvim / wezterm
  # / kitty edit-and-reload loop intact: change a file, see it live, no
  # `switch` needed. Configs whose format Nix models well (zsh, git, tmux,
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

    # The external tools the nvim config shells out to. Plugins stay under
    # lazy.nvim's management (config/nvim/lazy-lock.json is the lockfile);
    # nix only guarantees the binaries they need are present.
    #
    # The config is kickstart.nvim, which also runs mason.nvim — so on macOS
    # these are belt and braces. They matter on Linux, where mason's prebuilt
    # downloads often can't find a dynamic linker. Whichever resolves first on
    # PATH wins; both are the same servers.
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
