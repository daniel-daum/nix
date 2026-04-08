{ pkgs, ... }: {
  imports = [ ../modules/system-defaults.nix ];

  nixpkgs.hostPlatform = "aarch64-darwin";
  system.stateVersion = 6;
  users.users.daniel.home = "/Users/daniel";
  system.primaryUser = "daniel";
  nix.enable = false;
}
