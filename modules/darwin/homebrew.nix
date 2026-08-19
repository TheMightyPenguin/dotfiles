{ ... }:

# The honest answer to "can everything move to Nix?" on macOS is: not the GUI
# apps. Most Mac .app bundles either aren't in nixpkgs, or are but don't get
# the code-signing / login-item / system-extension treatment they need
# (Karabiner-Elements and Docker Desktop install privileged daemons; Raycast
# and 1Password ship signed updaters).
#
# So nix-darwin *declares* them and drives Homebrew to install them. It's still
# one file, still reproducible from a clean machine, still `switch` to apply —
# Homebrew is just the installer underneath. Linux never sees this file.
{
  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # "uninstall" removes anything not listed here; "zap" also deletes its
      # config. Start at "none" so the first switch can't surprise you, then
      # flip to "uninstall" once this list matches what you actually want.
      cleanup = "none";
    };

    # Requires: brew tap homebrew/bundle (nix-darwin handles taps below).
    taps = [ ];

    brews = [
      # Formulae that genuinely need to be brew-managed (services, or macOS
      # frameworks nixpkgs can't link against). Prefer adding to
      # modules/home/packages.nix instead — those work on Linux too.
    ];

    casks = [
      # window management / input
      "rectangle"
      "karabiner-elements"
      "raycast"
      "keepingyouawake"
      "choosy"

      # terminals & editors
      "wezterm"
      "kitty"
      "iterm2"
      "visual-studio-code@insiders"

      # dev
      "docker-desktop"
      "1password" # the `op` CLI comes from nixpkgs, this is the GUI app

      # everything else
      "google-chrome"
      "slack"
      "spotify"
      "discord"
      "telegram-desktop"
      "notion"
      "logi-options+" # successor to the discontinued logitech-options
    ];

    # Mac App Store apps, installed via `mas`. Find IDs with `mas search <name>`.
    masApps = { };
  };
}
