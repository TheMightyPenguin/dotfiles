UNAME := $(shell uname -s)
ARCH  := $(shell uname -m)

# Absolute path on purpose: darwin-rebuild must run as root, and sudo resets
# PATH to secure_path, which does not include /run/current-system/sw/bin — so
# plain `sudo darwin-rebuild` fails with "command not found" even when it is
# on your own PATH. /run/current-system always points at the live generation.
DARWIN_REBUILD := /run/current-system/sw/bin/darwin-rebuild

ifeq ($(UNAME),Darwin)
  ifeq ($(ARCH),x86_64)
    HOST := penguin-intel
  else
    HOST := penguin
  endif
else
  ifeq ($(ARCH),aarch64)
    TARGET := victor@linux-aarch64
  else
    TARGET := victor@linux
  endif
endif

.PHONY: bootstrap switch update check fmt gc rollback

## First switch on a machine that has nix but not darwin-rebuild yet.
## Uses the nix-darwin pinned in flake.lock rather than fetching master.
bootstrap:
ifeq ($(UNAME),Darwin)
	nix build .#darwinConfigurations.$(HOST).system
	@sudo -v
	@while kill -0 $$$$ 2>/dev/null; do sudo -n true 2>/dev/null; sleep 30; done &
	sudo ./result/sw/bin/darwin-rebuild switch --flake .#$(HOST)
else
	nix run home-manager/master -- switch --flake .#$(TARGET) -b hm-bak
endif

## Apply the config for this machine
switch:
ifeq ($(UNAME),Darwin)
	@# A switch needs sudo several times over (system activation, then
	@# Homebrew), and sudo's timestamp expires partway through a long brew
	@# run. Authenticate once up front, then refresh in the background until
	@# make exits, so it only ever asks once.
	@sudo -v
	@while kill -0 $$$$ 2>/dev/null; do sudo -n true 2>/dev/null; sleep 30; done &
	sudo $(DARWIN_REBUILD) switch --flake .#$(HOST)
else
	home-manager switch --flake .#$(TARGET) -b hm-bak
endif

## Bump nixpkgs / home-manager / nix-darwin, then apply
update:
	nix flake update
	$(MAKE) switch

## Evaluate every output without building — run this before committing
check:
	nix flake check

fmt:
	nix fmt

## Collect garbage older than 30 days
gc:
	nix-collect-garbage --delete-older-than 30d

## List generations you can roll back to
rollback:
ifeq ($(UNAME),Darwin)
	$(DARWIN_REBUILD) --list-generations
else
	home-manager generations
endif
