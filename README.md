# Dotfiles 🐧

One configuration, two operating systems. Nix builds the same shell, tools and
editor setup on macOS and on Linux, and rolls it back if it breaks.

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/TheMightyPenguin/dotfiles/HEAD/bootstrap.sh)"
```

That installs Nix if needed, clones this repo to `~/.dotfiles`, and applies the
right config for the machine. After that, `make switch` is the only command you
need.

## Layout

```
flake.nix              entry point — pins nixpkgs, defines every machine
modules/
  fonts.nix            font list, shared by both platforms
  home/                the cross-platform half: shell, git, tmux, tools
    packages.nix       CLI packages (identical on macOS and Linux)
    zsh.nix            zsh, plugins, aliases, fzf/zoxide/direnv/keychain
    git.nix            git, gh, lazygit, global gitignore
    tmux.nix           tmux + statusline
    starship.nix       prompt
    configs.nix        symlinks for nvim/wezterm/kitty/zellij + LSP toolchain
    darwin.nix         mac-only shell bits (Android SDK, pnpm, aliases)
    linux.nix          linux-only bits (clipboard, WSL handling)
  darwin/              the macOS-only half
    default.nix        system defaults, fonts, nix daemon settings
    homebrew.nix       GUI apps, declared here and installed via Homebrew
config/                app configs kept as native files (nvim, wezterm, kitty, zellij)
scripts/karabiner      TypeScript generator for karabiner.json
```

## Everyday use

```bash
make switch    # apply this repo to the current machine
make update    # bump nixpkgs/home-manager/nix-darwin, then apply
make check     # evaluate everything without building (run before committing)
make rollback  # list generations you can go back to
make gc        # reclaim disk from old generations
```

Rolling back is the part that pays for the whole thing:

```bash
darwin-rebuild --rollback          # macOS
home-manager generations           # Linux — then run the path it prints
```

## Cross-platform: what goes where

Three layers, and only one of them is macOS-specific.

**`modules/home/` — works everywhere.** ripgrep, fd, neovim, tmux, zsh, git,
starship, fzf, lazygit, node/rust/python toolchain managers. These are the same
derivations on `aarch64-darwin` and `x86_64-linux`; nothing is duplicated per
platform. Anything genuinely platform-shaped is guarded by
`lib.mkIf pkgs.stdenv.isDarwin` in `darwin.nix` / `linux.nix` rather than
branching inline.

**`modules/darwin/default.nix` — macOS system settings.** Key repeat rate,
Dock, Finder, natural-scrolling off, caps lock to control. Previously these
were clicked into System Settings by hand and lost on every new machine.

**`modules/darwin/homebrew.nix` — the honest exception.** macOS GUI apps do not
move to Nix cleanly. Karabiner-Elements and Docker Desktop install privileged
system daemons; Raycast, 1Password and Chrome ship signed self-updaters that
fight a read-only `/nix/store`. So nix-darwin *declares* them and drives
Homebrew as the installer. Still one file, still reproducible from a clean
machine, still applied by `make switch`. Linux never evaluates this file.

On Linux, `targets.genericLinux.enable` makes nix-installed apps, fonts and
`.desktop` entries visible to Ubuntu/Fedora/etc. — no NixOS required. WSL
specifics (DISPLAY, `win32yank` clipboard) live in `modules/home/linux.nix`
behind a `/proc/version` check.

## Editor and terminal configs

`config/nvim`, `config/wezterm`, `config/kitty` and `config/zellij` are **not**
rewritten in Nix. They're symlinked out of the store with
`mkOutOfStoreSymlink`, pointing at the working copy in this repo — so editing
`config/wezterm/wezterm.lua` still takes effect on save, with no rebuild.

Neovim keeps LazyVim and `lazy-lock.json` as its lockfile. Nix's job there is
only to guarantee the binaries LazyVim shells out to (language servers,
formatters, a compiler for treesitter) are on `PATH` — see
`modules/home/configs.nix`.

## Adding a machine

Add an entry to `flake.nix`:

```nix
homeConfigurations."victor@work" = mkHome "x86_64-linux";
```

or, for another Mac, a `darwinConfigurations` entry. Both reuse the same
`modules/home`, so a new machine starts fully configured.

## What isn't managed

Deliberately outside Nix:

- **`~/.local.sh`** — machine-local secrets, sourced by zsh if present.
  Restore with `op read "op://Private/.local.sh/notesPlain" > ~/.local.sh`.
- **`~/.ssh/github`** — the key itself. `keychain` loads it once it exists.
- **`iterm2-profiles.json`** — import manually from iTerm2's preferences.
- **`scripts/karabiner`** — run `yarn generate` there to produce
  `~/.config/karabiner/karabiner.json`; Karabiner rewrites that file itself, so
  Nix doesn't own it.

## Migrating from the old rcm setup

The previous version used [rcm](https://github.com/thoughtbot/rcm) plus an
imperative `init.sh` full of `brew install` lines. Those files are gone; their
contents live in the modules above:

| was                  | now                                              |
| -------------------- | ------------------------------------------------ |
| `setup.sh`/`init.sh` | `bootstrap.sh` + `modules/home/packages.nix`     |
| `rcrc` + `rcup`      | home-manager                                     |
| `zshrc` + zplug      | `modules/home/zsh.nix`                           |
| `gitconfig`          | `modules/home/git.nix`                           |
| `gitignore_global`   | `programs.git.ignores`                           |
| `tmux.conf` + snapshot | `modules/home/tmux.nix`                        |
| `config/starship.toml` | `modules/home/starship.nix`                    |
| `ssh/config`         | `programs.ssh.matchBlocks`                       |
| brew casks           | `modules/darwin/homebrew.nix`                    |

To leave the old setup behind on a machine that still has it: `rcdn` to remove
the rcm symlinks, then run `make switch`. home-manager backs up anything it
would overwrite with a `.hm-bak` suffix.

## A note on `flake.lock`

There is no committed lock file yet — the first `make switch` (or
`nix flake lock`) resolves `nixpkgs`, `home-manager` and `nix-darwin` to
current revisions and writes one. **Commit it.** That file is what makes the
Mac and the Linux box run byte-identical package versions, and what lets
`make update` be a deliberate, reviewable bump instead of a surprise.

## What Nix does *not* manage here

Deliberate gaps, so you know where to look when something isn't declarative:

- **Neovim plugins.** lazy.nvim owns `config/nvim/lazy-lock.json`, and
  mason.nvim owns its own LSP downloads. Nix installs neovim, a fallback set of
  LSP servers and a compiler for treesitter; the plugin managers do the rest.
  Two lockfiles, but each is managed by the tool that understands it.
- **GUI apps.** Declared in `modules/darwin/homebrew.nix`, installed by
  Homebrew. Reproducible, just not from the Nix store.
- **`~/.local.sh`.** Machine-local tokens and work config, sourced by zsh if it
  exists, never committed.
- **`config/zellij/config.kdl`.** Symlinked as a native file so it stays
  editable. Note that Zellij rewrites this file on version upgrades and drops
  your theme when it does — if that keeps happening, move it out of
  `configs.nix` and generate it from Nix, which makes it read-only.

## Notes on the migration

Things that changed rather than being ported as-is:

- `gitignore_global` had `core.excludesfile = /Users/victor/...` hardcoded, so
  it silently did nothing on Linux. Now `programs.git.ignores`.
- `JAVA_HOME` was pinned to `-v 11.0.13` and broke when that JDK went away.
  Now takes whatever `/usr/libexec/java_home` reports.
- The WSL `DISPLAY` export ran unconditionally and clobbered WSLg. Now only
  set when `DISPLAY` is empty.
- Android / gcloud / flutter / pnpm PATH entries are guarded by existence
  checks instead of being exported on every machine.
- zplug → oh-my-zsh via home-manager; `z` → zoxide; pyenv → uv.
- tmux statusline was gruvbox (a stale `tmuxline.snapshot`); it's tokyonight_moon
  now, matching wezterm, neovim and zellij.
- `bind-key -n C-m` from the old `tmux.conf` is commented out in
  `modules/home/tmux.nix` — `C-m` is Enter, and vim-tmux-navigator already
  covers what it was reaching for.

- `config/nvim` in this repo was a LazyVim config last touched in Sep 2024,
  while the config actually in use — `~/.config/nvim`, kickstart.nvim — had
  never been committed anywhere. The live one was adopted into the repo and is
  now symlinked back; the abandoned LazyVim tree is in git history at `1fb234d`.
