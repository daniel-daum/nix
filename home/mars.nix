{ pkgs, configName, jjSigningConfig, gitAllowedSigner, ... }: {
  imports = [
    ../dotfiles/git.nix
    ../dotfiles/zsh-mars.nix
  ];

  _module.args.configName = configName;

  home.username = "daniel";
  home.homeDirectory = "/home/daniel";
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    eza
    bat
    jujutsu
    helix
    delta
    difftastic
    jjui
    tmux
    nixd
    jq
    nil
  ];

  home.file.".gitallowedsigners".text = gitAllowedSigner + "\n";
  home.sessionVariables.JJ_CONFIG = "$HOME/.config/jj/conf.d";
  home.file.".config/jj/conf.d/config.toml".source = ../dotfiles/jj.toml;
  home.file.".config/jj/conf.d/signing.toml".source = jjSigningConfig;


  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
