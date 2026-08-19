{ pkgs, lib, email, ... }:

{
  programs.git = {
    enable = true;
    userName = "Victor Tortolero";
    userEmail = email;

    aliases = {
      dsf = "!f() { [ -z \"$GIT_PREFIX\" ] || cd \"$GIT_PREFIX\" && git diff --color \"$@\" | diff-so-fancy | less --tabs=4 -RFX; }; f";
      today = "log --since=7am";
      stashgrep = "!f() { for i in $(git stash list --format=\"%gd\"); do git stash show -p $i | grep -H --label=\"$i\" \"$@\"; done; }; f";
      undo = "reset --soft HEAD~";
    };

    extraConfig = {
      core = {
        editor = "nvim";
        autocrlf = false;
      };
      init.defaultBranch = "main";
      diff.tool = "default-difftool";
      difftool."default-difftool".cmd = "code --wait --diff $LOCAL $REMOTE";
      # osxkeychain ships with Apple git; on Linux fall back to an in-memory cache.
      credential.helper = if pkgs.stdenv.isDarwin then "osxkeychain" else "cache";
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

      # Editors
      ".vim/"
      ".direnv/"
    ];
  };

  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      editor = "nvim";
    };
  };

  programs.lazygit.enable = true;
}
