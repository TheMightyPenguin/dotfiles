UNAME := $(shell uname -s)
ARCH  := $(shell uname -m)

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
	sudo ./result/sw/bin/darwin-rebuild switch --flake .#$(HOST)
else
	nix run home-manager/master -- switch --flake .#$(TARGET) -b hm-bak
endif

## Apply the config for this machine
switch:
ifeq ($(UNAME),Darwin)
	sudo darwin-rebuild switch --flake .#$(HOST)
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
	darwin-rebuild --list-generations
else
	home-manager generations
endif
