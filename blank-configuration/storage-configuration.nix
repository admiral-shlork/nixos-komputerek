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
      luks_root_uuid = "99797e14-d02a-4073-b511-b8845fd0cef7";
    in {
      # LUKS container with root partition
      "luks-${luks_root_uuid}" = {
        device = "/dev/disk/by-uuid/${luks_root_uuid}";
        allowDiscards = true;
      };
    };
  };

  # Configuration for LUKS containers and key files
  environment.etc.crypttab.text = ''
    cryptslab0 UUID=05c46ba4-7a88-4290-8754-11160e363fc3 /root/slab0.key
    cryptslab1 UUID=5fc74d13-c55e-4dba-b9c0-3ef1b9171b35 /root/slab1.key
    cryptslab2 UUID=37f13c22-7daa-4a82-a9e0-f4e639a85ef1 /root/slab2.key
  '';

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

  fileSystems."/home/whatever/mnt/slab0" =
    { device = "/dev/disk/by-label/slab0";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/slab1" =
    { device = "/dev/disk/by-label/slab1";
      fsType = "ext4";
    };

  fileSystems."/home/whatever/mnt/slab2" =
    { device = "/dev/disk/by-label/slab2";
      fsType = "ext4";
    };
}
