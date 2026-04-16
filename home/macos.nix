{ pkgs, jjSigningConfig, gitAllowedSigner, ... }: {
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
    nixd
    jq
    claude-code
    nil
  ];

  home.file.".zsh_plugins.txt".source = ../dotfiles/zsh_plugins.txt;
  home.file.".gitallowedsigners".text = gitAllowedSigner + "\n";
  home.sessionVariables.JJ_CONFIG = "$HOME/.config/jj/conf.d";
  home.file.".config/jj/conf.d/config.toml".source = ../dotfiles/jj.toml;
  home.file.".config/jj/conf.d/signing.toml".source = jjSigningConfig;

  home.file.".config/zed/keymap.json".source = ../dotfiles/zed_keymap.json;
  # settings.json is NOT managed by home-manager — Zed needs to write to it
  # (e.g. ssh_connections for remote dev). Keep a reference copy at dotfiles/zed_settings.json.
  home.file.".config/zed/themes/violet_one_dark.json".source = ../dotfiles/zed_theme.json;
}
