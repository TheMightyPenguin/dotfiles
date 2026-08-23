#!/usr/bin/env bash
# One command from a blank machine (macOS or Linux) to a working setup.
#
#   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/TheMightyPenguin/dotfiles/HEAD/bootstrap.sh)"
#
# Installs Nix if it's missing, clones this repo, then applies the right
# configuration for the platform. Safe to re-run.
set -euo pipefail

DOTFILES="${DOTFILES:-$HOME/.dotfiles}"
REPO="${REPO:-https://github.com/TheMightyPenguin/dotfiles.git}"

log() { printf '\n\033[1;34m==>\033[0m %s\n' "$*"; }
die() { printf '\n\033[1;31mError:\033[0m %s\n' "$*" >&2; exit 1; }

# ── 1. Nix ────────────────────────────────────────────────────────────────
if ! command -v nix >/dev/null 2>&1; then
  # Determinate Systems' installer, but installing *upstream* Nix (no
  # --determinate flag): it has by far the best macOS story — it survives OS
  # upgrades and ships a real uninstaller — while leaving the daemon for
  # nix-darwin to manage, which is what modules/darwin/default.nix assumes.
  log "Installing Nix (Determinate Systems installer, upstream Nix)"
  curl --proto '=https' --tlsv1.2 -sSf -L \
    https://install.determinate.systems/nix | sh -s -- install --no-confirm
fi

# The installer doesn't touch the *current* shell, so source the profile.
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  # shellcheck disable=SC1091
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi
command -v nix >/dev/null 2>&1 || die "nix is still not on PATH — open a new shell and re-run."

# ── 2. This repo ──────────────────────────────────────────────────────────
if [ ! -d "$DOTFILES/.git" ]; then
  log "Cloning dotfiles into $DOTFILES"
  git clone "$REPO" "$DOTFILES"
fi
cd "$DOTFILES"

# ── 3. Apply ──────────────────────────────────────────────────────────────
case "$(uname -s)" in
  Darwin)
    host="penguin"
    [ "$(uname -m)" = "x86_64" ] && host="penguin-intel"

    # nix-darwin declares the GUI casks but does not install Homebrew itself,
    # so it has to exist first. See modules/darwin/homebrew.nix for why the
    # Mac apps aren't in Nix.
    if ! command -v brew >/dev/null 2>&1; then
      log "Installing Homebrew (installer for the GUI casks)"
      NONINTERACTIVE=1 /bin/bash -c \
        "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    for prefix in /opt/homebrew /usr/local; do
      [ -x "$prefix/bin/brew" ] && eval "$("$prefix/bin/brew" shellenv)" && break
    done

    # Homebrew refuses to load casks from third-party taps until they are
    # trusted, and nix-darwin has no option for it (trust lives in
    # ~/.homebrew/trust.json, outside the store). Running bootstrap.sh is the
    # point where you accept this repo's choices, so do it here — keep this
    # list in sync with `taps` in modules/darwin/homebrew.nix.
    for tap in nikitabobko/tap; do
      if ! brew tap-info --json "$tap" >/dev/null 2>&1; then
        brew tap "$tap"
      fi
      log "Trusting third-party tap $tap"
      brew trust "$tap" || true
    done

    log "macOS detected — building nix-darwin config .#$host"
    # First run: darwin-rebuild isn't installed yet, so go through nix run.
    if command -v darwin-rebuild >/dev/null 2>&1; then
      sudo darwin-rebuild switch --flake ".#$host"
    else
      # No sudo here: `sudo nix` usually can't find nix on root's PATH.
      # darwin-rebuild elevates itself for the system activation step.
      nix run nix-darwin/master#darwin-rebuild -- switch --flake ".#$host"
    fi
    ;;
  Linux)
    target="victor@linux"
    [ "$(uname -m)" = "aarch64" ] && target="victor@linux-aarch64"
    log "Linux detected — building home-manager config .#$target"
    nix run home-manager/master -- switch --flake ".#$target" -b hm-bak
    ;;
  *)
    die "Unsupported platform: $(uname -s)"
    ;;
esac

log "Done. Start a new shell."
cat <<'EOF'

Two things Nix deliberately does not do for you:

  1. Machine-local secrets. Pull them down with 1Password once `op` is
     signed in:
         op read "op://Private/.local.sh/notesPlain" > ~/.local.sh

  2. SSH keys. Generate or restore ~/.ssh/github; keychain picks it up
     from there on the next shell.

EOF
