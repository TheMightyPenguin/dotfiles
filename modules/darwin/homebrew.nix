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
#
# This list was reconciled against `brew list --cask` and /Applications on the
# current machine, so a fresh `switch` reproduces what's actually installed.
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

    # Third-party taps. Homebrew will not load a cask from one of these until
    # the tap is *trusted* as well — declaring it here only makes `brew tap`
    # run. See bootstrap.sh, which does the trusting.
    #
    # Keep this list as short as possible: every entry is an arbitrary GitHub
    # repo whose contents can change under you, which is exactly why Homebrew
    # started asking. crush, codecrafters, sqld and turso all came from taps
    # and are all in nixpkgs, so they moved to modules/home/packages.nix and
    # their taps are gone. aerospace is the only one left, because it needs
    # macOS Accessibility permission bound to a stable binary path.
    taps = [
      # `trusted = true` puts `trusted: true` on this tap's Brewfile entry, so
      # `brew bundle` trusts it during activation. That's what makes a switch
      # work unattended — Homebrew 6.0 turned on HOMEBREW_REQUIRE_TAP_TRUST,
      # which otherwise aborts activation on any non-official tap.
      #
      # Trusting a tap means trusting every current and future formula and
      # cask in an arbitrary GitHub repo. That's a real decision, but it's one
      # made here, in a reviewed commit, rather than typed into a prompt and
      # forgotten — which is the better place for it.
      {
        name = "nikitabobko/tap"; # aerospace
        trusted = true;
      }
    ];

    brews = [
      # Formulae that genuinely need to be brew-managed (services, or macOS
      # frameworks nixpkgs can't link against). Prefer adding to
      # modules/home/packages.nix instead — those work on Linux too.
    ];

    casks = [
      # window management / input
      "rectangle"
      # From nikitabobko/tap (see taps above), not homebrew-core. It is also
      # in nixpkgs, but AeroSpace needs macOS Accessibility permission, which
      # is granted per binary path — a /nix/store path changes on every
      # update, so you would re-grant it after every `make update`. Homebrew
      # keeps the path stable.
      "aerospace" # tiling WM
      "karabiner-elements"
      "raycast"
      "keepingyouawake"
      "choosy"
      # Reverses the mouse wheel while leaving the trackpad natural — a
      # distinction the NSGlobalDomain swipescrolldirection flag can't make,
      # which is why this cask stays rather than being replaced by it.
      "scroll-reverser"

      # terminals
      "wezterm" # primary
      "kitty"
      "ghostty"

      # editors
      "visual-studio-code"
      "visual-studio-code@insiders"
      "cursor"
      "zed"

      # browsers
      "google-chrome"
      "arc"

      # dev
      "docker-desktop"
      "1password" # GUI app; the `op` CLI comes from nixpkgs

      # everything else
      # spotify, discord, notion and obsidian moved to nixpkgs — see
      # modules/home/packages.nix. They were the only casks with neither an
      # Accessibility grant nor a privileged daemon, which is what makes a
      # nix-installed Mac app painful: macOS binds those grants to the
      # binary's path, and a /nix/store path changes on every update.
      "telegram-desktop"
      "logi-options+" # successor to the discontinued logitech-options
    ];

    # Mac App Store apps, installed via `mas`. Find IDs with `mas search <name>`.
    masApps = { };
  };
}
