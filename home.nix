{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./home-configuration/gnome-configuration.nix
    ];

  # Home Manager configuration options go here
  home = {
    username = "justyna";
    homeDirectory = "/home/justyna";
    stateVersion = "24.11";
    packages = with pkgs; [
      calibre
      dropbox
      evince
      floorp
      gimp
      gnome-screenshot
      keepassxc
      libreoffice
      librewolf
      # lutris
      # mangohud
      obsidian
      protonvpn-gui
      signal-desktop
      telegram-desktop
      ungoogled-chromium
      vivaldi
      vlc
    ];
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      alias ll='ls -alhF'
      alias la='ls -A'
      alias l='ls -CF'
    '';
  };
}
