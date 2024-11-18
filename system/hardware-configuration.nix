{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  # Configure boot
  boot = {
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];
    initrd = {
      kernelModules = [];
      availableKernelModules = ["xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" "rtsx_pci_sdmmc"];
    };
  };

  # Configure filesystems
  fileSystems = {
    "/" = {
      fsType = "ext4";
      device = "/dev/disk/by-label/NIXOS-ROOT";
    };

    "/boot" = {
      fsType = "vfat";
      device = "/dev/disk/by-label/NIXOS-BOOT";
      options = ["fmask=0077" "dmask=0077"];
    };

    "/home" = {
      fsType = "ext4";
      device = "/dev/disk/by-label/NIXOS-HOME";
    };
  };

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;

  # Host platform
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  # Update intel microcode
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
