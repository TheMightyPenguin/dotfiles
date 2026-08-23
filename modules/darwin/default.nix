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

  # This machine runs Determinate Nix (`nix --version` says "Determinate Nix"),
  # whose own daemon — determinate-nixd — owns /etc/nix/nix.conf, the launchd
  # job and garbage collection. nix-darwin must not fight it for those, so the
  # whole nix.* surface is off here.
  #
  # Consequence: nix.settings / nix.gc / nix.optimise do NOT belong in this
  # file. Extra nix settings go in /etc/nix/nix.custom.conf (the Determinate
  # nix.conf `!include`s it and won't overwrite it); GC is handled by
  # `determinate-nixd` and by `make gc`.
  #
  # If you ever move to upstream Nix, flip this to true and put the settings
  # back — see git history for the block that was here.
  nix.enable = false;

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
      # NOT setting com.apple.swipescrolldirection: the Scroll Reverser cask
      # (see homebrew.nix) reverses the mouse wheel while leaving the trackpad
      # natural. Flipping this flag too would double-negate the trackpad.
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

    # Don't nag about apps downloaded from the internet.
    LaunchServices.LSQuarantine = false;
  };

  # Touch ID for sudo, which is what makes `make switch` bearable: a switch
  # takes several sudo calls (activation, then Homebrew), and each one is
  # otherwise a password prompt.
  #
  # `reattach` pulls in pam_reattach, without which Touch ID silently does
  # nothing inside tmux — the prompt falls back to a password and it looks
  # broken. Worth having given how much of the work here happens in tmux.
  #
  # This writes /etc/pam.d/sudo_local, which macOS 14+ includes automatically
  # and, unlike editing /etc/pam.d/sudo directly, survives OS updates.
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true;
  };

  # Karabiner-Elements handles the Hyper key (see ../../scripts/karabiner);
  # caps lock -> control is a system-level toggle worth having regardless.
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToControl = true;
  };
}
