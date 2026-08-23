{ lib, pkgs, ... }:

{
  # Everything in here is inert on macOS.
  config = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
    # Makes nix-installed apps, icons, fonts and .desktop entries visible to a
    # non-NixOS distro (Ubuntu, Fedora, WSL...). Harmless on NixOS.
    targets.genericLinux.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      xclip
      wl-clipboard
    ];

    programs.zsh.initContent = lib.mkAfter ''
      # ── WSL only ────────────────────────────────────────────────────────
      if [[ -r /proc/version ]] && grep -qi microsoft /proc/version; then
        # X server running on the Windows host (VcXsrv/X410 style setups).
        # WSLg users already get DISPLAY set for them, so don't clobber it.
        if [[ -z "$DISPLAY" ]]; then
          export DISPLAY="$(awk '/nameserver/ {print $2; exit}' /etc/resolv.conf):0"
        fi

        # Use the Windows clipboard from nvim/tmux if win32yank is installed.
        (( $+commands[win32yank.exe] )) && alias pbcopy='win32yank.exe -i --crlf' \
                                        && alias pbpaste='win32yank.exe -o --lf'
      fi
    '';
  };
}
