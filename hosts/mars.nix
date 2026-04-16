{ pkgs, modulesPath, ... }:

{
  imports = [
    "${modulesPath}/virtualisation/lxc-container.nix"
    ./orbstack.nix
  ];

  # System
  networking.hostName = "mars";
  time.timeZone = "America/Los_Angeles";
  system.stateVersion = "25.11";

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  # User
  users.mutableUsers = true;
  users.users.daniel = {
    uid = 501;
    extraGroups = [ "wheel" "orbstack" ];
    isSystemUser = true;
    group = "users";
    createHome = true;
    home = "/home/daniel";
    homeMode = "700";
    shell = pkgs.zsh;
  };

  # Shell
  programs.zsh.enable = true;

  # nix-ld for dynamically linked binaries (Zed node.js downloads, etc.)
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    zlib
  ];

  # Networking (OrbStack default)
  networking = {
    dhcpcd.enable = false;
    useDHCP = false;
    useHostResolvConf = false;
  };

  systemd.network = {
    enable = true;
    networks."50-eth0" = {
      matchConfig.Name = "eth0";
      networkConfig = {
        DHCP = "ipv4";
        IPv6AcceptRA = true;
      };
      linkConfig.RequiredForOnline = "routable";
    };
  };

  # Packages needed at system level
  environment.systemPackages = with pkgs; [ git ];
}
