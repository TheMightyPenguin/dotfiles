# Shared between the home-manager profile (Linux) and nix-darwin's
# system-wide `fonts.packages` (macOS), so both platforms render the same
# starship / tmux / neovim glyphs.
pkgs: with pkgs; [
  iosevka
  nerd-fonts.iosevka-term
  nerd-fonts.symbols-only
]
