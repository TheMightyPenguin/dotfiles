{ pkgs, username, ... }:

{
  imports = [ ./homebrew.nix ];

  # Bump only after reading the nix-darwin changelog.
  system.stateVersion = 6;

  # Required by nix-darwin for the user-scoped `system.defaults` below.
  system.primaryUser = username;

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Faster rebuilds on a multi-core Mac.
    max-jobs = "auto";
  };
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    interval = {
      Weekday = 0;
      Hour = 3;
      Minute = 0;
    };
    options = "--delete-older-than 30d";
  };
  # If you install Determinate Nix instead of the nix-darwin-managed daemon,
  # set this to false — Determinate manages the daemon itself.
  # nix.enable = false;

  # Makes /etc/zshrc source the nix profile, so login shells see nix paths.
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  # Same font derivations the Linux profile installs — see ../fonts.nix.
  fonts.packages = import ../fonts.nix pkgs;

  system.defaults = {
    NSGlobalDomain = {
      # Fast key repeat — the single biggest quality-of-life setting.
      KeyRepeat = 2;
      InitialKeyRepeat = 15;
      ApplePressAndHoldEnabled = false; # hold a key to repeat, not to accent-pick
      AppleShowAllExtensions = true;
      AppleInterfaceStyleSwitchesAutomatically = true;
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSNavPanelExpandedStateForSaveMode = true;
      "com.apple.swipescrolldirection" = false; # replaces the Scroll Reverser cask
    };

    dock = {
      autohide = true;
      autohide-delay = 0.0;
      show-recents = false;
      mru-spaces = false; # don't reorder spaces — keeps Rectangle/hotkeys sane
      tilesize = 48;
    };

    finder = {
      AppleShowAllExtensions = true;
      FXPreferredViewStyle = "Nlsv"; # list view
      ShowPathbar = true;
      ShowStatusBar = true;
      _FXShowPosixPathInTitle = true;
    };

    screencapture.location = "~/Pictures/Screenshots";

    trackpad = {
      Clicking = true;
      TrackpadThreeFingerDrag = true;
    };

    # Karabiner-Elements handles the Hyper key (see ../../scripts/karabiner),
    # but caps lock -> control is a system-level toggle worth having anyway.
    LaunchServices.LSQuarantine = false;
  };

  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
