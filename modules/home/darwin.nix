{ config, lib, pkgs, ... }:

{
  # Everything in here is inert on Linux.
  config = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    home.sessionVariables = {
      # https://blog.phusion.nl/2017/10/13/why-ruby-app-servers-break-on-macos-high-sierra
      OBJC_DISABLE_INITIALIZE_FORK_SAFETY = "YES";
    };

    programs.zsh = {
      shellAliases = {
        iosim = "open -a Simulator";

        # iCloud Drive locations
        ic = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs";
        samples = "cd ~/Library/Mobile\\ Documents/com~apple~CloudDocs/Music/Samples";
        ovault = "cd ~/Library/Mobile\\ Documents/iCloud~md~obsidian/Documents";
      };

      initContent = lib.mkAfter ''
        # Homebrew is still the installer for the GUI casks (see
        # modules/darwin/homebrew.nix), so put it on PATH — but behind the nix
        # profile, so a tool declared in packages.nix always wins.
        for brew_prefix in /opt/homebrew /usr/local; do
          if [[ -x "$brew_prefix/bin/brew" ]]; then
            eval "$("$brew_prefix/bin/brew" shellenv)"
            path=("$HOME/.nix-profile/bin" $path)
            break
          fi
        done

        # React Native / Android — only exported if the SDK is actually there.
        # https://reactnative.dev/docs/environment-setup
        if [[ -d "$HOME/Library/Android/sdk" ]]; then
          export ANDROID_HOME="$HOME/Library/Android/sdk"
          path=(
            "$ANDROID_HOME/emulator"
            "$ANDROID_HOME/tools"
            "$ANDROID_HOME/tools/bin"
            "$ANDROID_HOME/platform-tools"
            $path
          )
        fi
        if [[ -x /usr/libexec/java_home ]]; then
          # The old zshrc pinned -v 11.0.13, which broke as soon as that JDK
          # was gone. Take whatever the system considers current.
          export JAVA_HOME="$(/usr/libexec/java_home 2>/dev/null)"
        fi

        # pnpm's global bin dir (pnpm itself comes from corepack, not nix)
        export PNPM_HOME="$HOME/Library/pnpm"
        path=("$PNPM_HOME" $path)

        # Flutter / Dart, if installed by hand
        [[ -d "$HOME/flutter/bin" ]] && path=($path "$HOME/flutter/bin")
        [[ -d "$HOME/.pub-cache/bin" ]] && path=($path "$HOME/.pub-cache/bin")

        # Google Cloud SDK ships its own completion; only source it if present.
        if [[ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]]; then
          source "$HOME/google-cloud-sdk/path.zsh.inc"
          source "$HOME/google-cloud-sdk/completion.zsh.inc"
        fi
      '';
    };
  };
}
