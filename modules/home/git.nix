{ pkgs, lib, email, ... }:

{
  programs.git = {
    enable = true;

    # home-manager collapsed userName/userEmail/aliases/extraConfig into a
    # single `settings` attrset that mirrors git-config(1) section names.
    settings = {
      user = {
        name = "Victor Tortolero";
        email = email;
      };

      alias = {
        dsf = "!f() { [ -z \"$GIT_PREFIX\" ] || cd \"$GIT_PREFIX\" && git diff --color \"$@\" | diff-so-fancy | less --tabs=4 -RFX; }; f";
        today = "log --since=7am";
        stashgrep = "!f() { for i in $(git stash list --format=\"%gd\"); do git stash show -p $i | grep -H --label=\"$i\" \"$@\"; done; }; f";
        undo = "reset --soft HEAD~";
      };

      core = {
        editor = "nvim";
        autocrlf = false;
      };

      init.defaultBranch = "main";
      diff.tool = "default-difftool";
      difftool."default-difftool".cmd = "code --wait --diff $LOCAL $REMOTE";

      # osxkeychain ships with Apple git; on Linux fall back to an in-memory
      # cache rather than writing credentials to disk.
      credential.helper = if pkgs.stdenv.hostPlatform.isDarwin then "osxkeychain" else "cache";

      push.autoSetupRemote = true;
      pull.rebase = true;
      rebase.autoStash = true;
    };

    lfs.enable = true;

    # Replaces core.excludesfile = /Users/victor/.gitignore_global, which was
    # hardcoded to a macOS path and silently did nothing on Linux.
    ignores = [
      # Compiled source
      "*.com"
      "*.class"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"

      # Packages — better to unpack and commit the raw source
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"

      # Logs and databases
      "*.log"
      "*.sqlite"

      # OS generated files
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"

      # Editors / tooling
      ".vim/"
      ".direnv/"
    ];
  };

  programs.gh = {
    enable = true;
    settings = {
      # Was https before the migration. ssh is the better default here since
      # ~/.ssh/config routes github.com over port 443 (see ./zsh.nix), which
      # works from networks that block 22.
      git_protocol = "ssh";
      editor = "nvim";

      # home-manager writes this file wholesale, so anything not declared here
      # is dropped. `co` was in the hand-written config and would have been
      # lost silently.
      aliases = {
        co = "pr checkout";
      };
    };
  };

  programs.lazygit.enable = true;
}
