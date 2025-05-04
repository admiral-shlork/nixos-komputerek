{ config, pkgs, modulesPath, ... }:

{
  boot = {
    initrd.availableKernelModules = [ "ahci" "xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_usb_sdmmc" ];
    initrd.kernelModules = [ "dm-snapshot" ];
    # initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_6_12; #kernelPackages = pkgs.linuxPackages_latest;
    kernelParams = [ "kvm.enable_virt_at_load=0" ];
    extraModulePackages = [ ];
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    initrd.luks.devices = let
      luks_root_uuid = "00000000000000000000000000000";
    in {
      # LUKS container with root partition
      "luks-${luks_root_uuid}" = {
        device = "/dev/disk/by-uuid/${luks_root_uuid}";
        allowDiscards = true;
      };
    };
  };

  # swapDevices = [{ 
  #     device = "/dev/disk/by-uuid/c30a3550-ab3b-4820-afc7-b833f4f3b36c";
      # device = "/swapfile";
      # size = 64 * 1024;
  #   }];

  fileSystems."/" =
    { device = "/dev/disk/by-label/root";
      fsType = "ext4";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-label/BOOT";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };
}
