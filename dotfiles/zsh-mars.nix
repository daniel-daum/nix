{ configName, ... }: {
  programs.zsh = {
    enable = true;
    initContent = ''
      alias ll="eza -al --group-directories-first --icons --git --color=auto --long --header --classify"
      alias cat='bat'
      alias rebuild="sudo nixos-rebuild switch --flake /mnt/mac/Users/daniel/.config/nix#${configName}"

      # Auto-Warpify
      [[ "$-" == *i* ]] && printf '\eP$f{"hook": "SourcedRcFileForWarp", "value": { "shell": "zsh", "uname": "'$(uname)'" }}\x9c'
    '';
  };
}
