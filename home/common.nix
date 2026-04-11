{ pkgs, ... }: {
  imports = [
    ../dotfiles/git.nix
    ../dotfiles/zsh.nix
    ../dotfiles/ssh.nix
  ];

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
    antidote
  ];

  home.file.".zsh_plugins.txt".source = ../dotfiles/zsh_plugins.txt;
  home.file.".config/jj/config.toml".source = ../dotfiles/jj.toml;
}
