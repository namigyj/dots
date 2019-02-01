{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hw-laptop.nix
      ./configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot= {
    loader= {
      grub = {
        enable = true;
        version = 2;
        devices = [ "nodev" ];
        efiSupport = true;
      };
    };
    blacklistedKernelModules = [ "radeon" ];
  };

  networking.networkmanager.enable = true;
  networking.hostName = "kusanagi"; # Define your hostname.

  # List services that you want to enable:
  services = {
  # Enable the X11 windowing system.
    xserver = {
      libinput.enable = true;
      libinput.middleEmulation = true;
      libinput.tapping = true;
    };
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}