{ config, pkgs, lib, modulesPath, ... }:

{
  networking.hostName = "komputerek";
  networking.useDHCP = lib.mkDefault true;
  networking.networkmanager.enable = true;
}
