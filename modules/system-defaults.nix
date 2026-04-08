{ ... }: {
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      NSAutomaticCapitalizationEnabled = false;
    };

    dock = {
      autohide = true;
      autohide-time-modifier = 0.15;
    };
  };
}
