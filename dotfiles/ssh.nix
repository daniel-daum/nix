{ ... }: {
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    extraConfig = ''
      Include ~/.orbstack/ssh/config
    '';
    matchBlocks = {
      "*" = {
        identityAgent = "/Users/daniel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
      };
      "ziost" = {
        identityAgent = "/Users/daniel/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh";
        hostname = "ziost.swordfish-magellanic.ts.net";
        user = "maliciouspickle";
        port = 2222;
      };
    };
  };
}