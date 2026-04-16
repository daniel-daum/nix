{ ... }: {
  system.defaults = {
    CustomSystemPreferences = {
      "com.apple.loginwindow" = {
        HideUserAvatarAndName = true;
      };
    };

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
