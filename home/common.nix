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
    nil
  ];

  home.file.".zsh_plugins.txt".source = ../dotfiles/zsh_plugins.txt;
  home.file.".gitallowedsigners".text = gitAllowedSigner + "\n";
  home.sessionVariables.JJ_CONFIG = "$HOME/.config/jj/conf.d";
  home.file.".config/jj/conf.d/config.toml".source = ../dotfiles/jj.toml;
  home.file.".config/jj/conf.d/signing.toml".source = jjSigningConfig;

  home.file.".config/zed/keymap.json".source= ../dotfiles/zed_keymap.json;
  home.file.".config/zed/settings.json".source= ../dotfiles/zed_settings.json;
  home.file.".config/zed/themes/violet_one_dark.json".source= ../dotfiles/zed_theme.json;
}
