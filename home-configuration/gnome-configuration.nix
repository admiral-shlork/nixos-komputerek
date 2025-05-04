{ config, pkgs, lib, ... }:

{
  nixpkgs.overlays = [
    # GNOME 46: triple-buffering-v4-46
    (final: prev: {
      mutter = prev.mutter.overrideAttrs (old: {
        src = pkgs.fetchFromGitLab  {
          domain = "gitlab.gnome.org";
          owner = "vanvugt";
          repo = "mutter";
          rev = "triple-buffering-v4-46";
          hash = "sha256-C2VfW3ThPEZ37YkX7ejlyumLnWa9oij333d5c4yfZxc=";
        };
      });
    })
  ];

  dconf.settings = {
    # Enable location
    "org/gnome/system/location" = {
      enabled = true;
      max-accuracy-level = "exact";
    };
    # Disable lock screen notifications
    "org/gnome/desktop/notifications" = {
      show-in-lock-screen = false;
    };
    # Show weekday in calendar
    "org/gnome/desktop/calendar" = {
      show-weekdate = true;
    };
    # Enable active edges for window tiling
    "org/gnome/mutter" = {
      edge-tiling = true;
    };
    # Enable nightlight
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };
    # Keyboard bindings
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Super>e";
      command = "/run/current-system/sw/bin/nautilus --new-window";
      name = "Nautilus";
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      binding = "Print";
      command = "/etc/profiles/per-user/whatever/bin/gnome-screenshot --interactive";
      name = "Screenshot";
    };
    # Enabled extensions
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        appindicator.extensionUuid
        caffeine.extensionUuid
        dash-to-panel.extensionUuid
        date-menu-formatter.extensionUuid
        night-theme-switcher.extensionUuid
        no-overview.extensionUuid
        random-wallpaper.extensionUuid
      ];
    };
    # Date-menu-formatter preferences
    "org/gnome/shell/extensions/date-menu-formatter" = {
      pattern = "EEEE, d MMMM yyyy  -  HH:mm:ss";
      text-align = "right";
      update-level = "2";
    };
    # Caffeine preferences
    "org/gnome/shell/extensions/caffeine" = {
      indicator-position-max = "2";
      restore-state = true;
      show-indicator = "always";
      show-notifications = false;
    };
    # Disable natural scrolling on a trackpoint and enable two finger scrolling
    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enable = true;
      natural-scroll = false;
    };
    # Fractional scaling in Gnome
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
  };  
}
