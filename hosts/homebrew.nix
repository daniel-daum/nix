{ ... }: {
  homebrew = {
    enable = true;
    onActivation.cleanup = "none";
    taps = [ "macos-fuse-t/homebrew-cask" ];
    brews = [ "mas" ];
    casks = [
      "appcleaner"
      "alt-tab"
      "anytype"
      "bloom"
      "bruno"
      "calibre"
      "cork"
      "cryptomator"
      "daisydisk"
      "dbngin"
      "font-geist-mono"
      "fuse-t"
      "iina"
      "little-snitch"
      "mac-mouse-fix"
      "orbstack"
      "proton-mail"
      "proton-pass"
      "raycast"
      "rectangle"
      "secretive"
      "tailscale-app"
      "warp"
      "yubico-authenticator"
      "zed"
    ];
    masApps = {
      "Anybox - Bookmark & Read Later" = 1593408455;
      "Brother iPrint&Scan" = 1193539993;
      "Developer" = 640199958;
      "Dropover" = 1355679052;
      "Kagi for Safari" = 1622835804;
      "Keynote" = 361285480;
      "LiquidFetch" = 6757637185;
      "Numbers" = 361304891;
      "Pages" = 361309726;
      "Panels" = 1236567663;
      "Pixelmator Pro" = 1289583905;
      "Scrap Paper" = 1448441317;
      "SnippetsLab" = 1006087419;
      "Wipr" = 1662217862;
    };
  };
}
