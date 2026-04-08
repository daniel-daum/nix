{ ... }: {
  imports = [ ./common.nix ./homebrew.nix ];
  networking.hostName = "kashyyk";
}
