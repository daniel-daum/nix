{ gitSigningKey, ... }: {
  programs.git = {
    enable = true;
    signing.format = null;
    settings = {
      user.name = "daniel daum";
      user.email = "daniel@danieldaum.net";
      user.signingkey = gitSigningKey;
      push.autoSetupRemote = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      "gpg \"ssh\"".allowedSignersFile = "~/.gitallowedsigners";
      tag.gpgSign = true;
      core.pager = "delta";
      interactive.diffFilter = "delta --color-only";
      delta = {
        navigate = true;
        dark = true;
      };
      merge.conflictStyle = "zdiff3";
      diff.tool = "difftastic";
      "difftool \"difftastic\"".cmd = "difft \"$LOCAL\" \"$REMOTE\"";
      difftool.prompt = false;
      pager.difftool = "less -R";
      alias = {
        st = "status --short --branch";
        a  = "add";
        ap = "add --patch";
        c  = "commit";
        cm = "commit --message";
        pl = "pull --rebase";
        ps = "push";
        fp = "fetch --prune";
        sweep = "!git branch --merged | grep -v '\\*\\|main\\|master' | xargs -n 1 git branch -d";
      };
    };
  };
}
