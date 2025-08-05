{ config, pkgs, lib, inputs, modulesPath, ... }: {

  # Desktop-specific settings
  networking.hostName = "soren-desktop";
  
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9e4e3ecf-cca3-4524-96f0-330bedc81d7a";
      fsType = "ext4";
    };

  boot.initrd.luks.devices."luks-ee5a129f-74a1-4ee8-b1c2-2fb26c4ccba2".device = "/dev/disk/by-uuid/ee5a129f-74a1-4ee8-b1c2-2fb26c4ccba2";

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/6C03-A2F0";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ];

  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
  
  # GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
}

