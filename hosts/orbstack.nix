# NixOS configuration for OrbStack VM
# Rebuild: sudo nixos-rebuild switch --flake /mnt/mac/Users/daniel/.config/nix#orbstack
{ pkgs, ... }: {
  imports = [ /etc/nixos/hardware-configuration.nix ];

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.11";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.daniel = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  programs.zsh.enable = true;
}
