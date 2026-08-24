{ ... }:

# The prompt lives in config/starship.toml, symlinked by ./configs.nix rather
# than modelled as a Nix attrset.
#
# It was an attrset. Translating the TOML once silently dropped 15 of its 16
# Nerd Font glyphs — every ""/U+E0B4 segment separator, the leading U+E711
# icon and the branch symbol — because they sit in the Unicode private use
# area and survive a round trip only if every step preserves them exactly.
# What shipped was a prompt full of empty brackets, which looks like a missing
# font and cannot be fixed by installing one.
#
# The file is static TOML with no cross-platform logic, so Nix models nothing
# useful here. Keeping it verbatim removes the whole class of bug, and edits
# apply on the next prompt instead of needing a rebuild.
{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
