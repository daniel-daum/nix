{ pkgs, ... }: {
  home.username = "daniel";
  home.homeDirectory = "/Users/daniel";
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    eza
    bat
    jujutsu
    helix
    delta
    difftastic
    jjui
  ];

  programs.zsh = {
    enable = true;
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
    '';
    initExtra = ''
      source $(brew --prefix)/share/antidote/antidote.zsh
      antidote load
      ZSH_THEME="robbyrussell"
      alias ll="eza -al --group-directories-first --icons --git --color=auto --long --header --classify"
      alias cat='bat'
    '';
  };

  home.file.".zsh_plugins.txt".text = ''
    getantidote/use-omz
    ohmyzsh/ohmyzsh path:themes/robbyrussell.zsh-theme
  '';
  programs.git = {
    enable = true;
    userName = "daniel daum";
    userEmail = "daniel@danieldaum.net";
    extraConfig = {
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
      include.path = "~/.gitconfig.local";
    };
    aliases = {
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

  home.file.".config/jj/config.toml".text = ''
    [user]
    name = "daniel daum"
    email = "daniel@danieldaum.net"

    [ui]
    pager = "delta"
    diff.format = "git"
    diff.tool = "difftastic"
    default-command = "log"

    [git]
    write-change-id-header = true
    sign-on-push = true

    [signing]
    behavior = "drop"
    backend = "ssh"
    key = ""

    [signing.backends.ssh]
    allowed-signers = "/Users/daniel/.gitallowedsigners"

    [template-aliases]
    "format_timestamp(timestamp)" = "timestamp.ago()"

    [aliases]
    init  = ["git", "init"]
    push  = ["git", "push"]
    pull  = ["git", "fetch"]
    clone = ["git", "clone"]
    tug = ["bookmark", "move", "--from", "heads(::@- & bookmarks())", "--to", "@-"]

    [templates]
    log = """
      if(root,
        format_root_commit(self),
        label(if(current_working_copy, "working_copy"),
          concat(
            separate(" ",
              change_id.short(),
              if(empty, label("empty", "(empty)")),
              if(description,
                description.first_line(),
                label(if(empty, "empty"), description_placeholder),
              ),
              bookmarks,
              if(conflict, label("conflict", "conflict")),
            ) ++ "\\n",
          ),
        )
      )
    """

    [merge-tools.difftastic]
    program = "difft"
    diff-args = ["--color=always", "--display=side-by-side", "$left", "$right"]
  '';

  programs.ssh = {
    enable = true;
    extraConfig = ''
      Include ~/.orbstack/ssh/config
    '';
    matchBlocks = {
      "*" = {
        identityAgent = "/Users/daniel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
      };
      "ziost" = {
        identityAgent = "/Users/daniel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
        hostname = "ziost.swordfish-magellanic.ts.net";
        user = "maliciouspickle";
        port = 2222;
      };
    };
  };
}
