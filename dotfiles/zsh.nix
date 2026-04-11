{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    profileExtra = ''
      eval "$(/opt/homebrew/bin/brew shellenv)"
      export SSH_AUTH_SOCK="$HOME/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh"
    '';
    initContent = ''
      source ${pkgs.antidote}/share/antidote/antidote.zsh
      antidote load
      ZSH_THEME="robbyrussell"
      alias ll="eza -al --group-directories-first --icons --git --color=auto --long --header --classify"
      alias cat='bat'
      alias rebuild = sudo darwin-rebuild switch --flake ~/.config/nix
    '';
  };
}
