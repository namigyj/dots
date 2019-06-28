# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{ config, pkgs, ... }:

{
  boot.tmpOnTmpfs = true;

  systemd.generator-packages = [ pkgs.systemd-cryptsetup-generator ];

  # Select internationalisation properties.
  i18n = {
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  hardware = {
    pulseaudio.enable = true;
    cpu.intel.updateMicrocode = true;
  };

  programs.bash.enableCompletion = true;

  # List services that you want to enable:
  services = {
  # Enable the X11 windowing system.
    xserver = {
      enable = true;
      layout = "us,us(intl)";
      xkbOptions = "grp:shift_caps_toggle,nbsp:level2";

      desktopManager = {
        default = "none";
        xterm.enable = false;
      };

      #windowManager.i3.enable = true;
      windowManager.xmonad.enable = true;
      windowManager.xmonad.extraPackages = self: [ self.xmonad-contrib ];
      windowManager.xmonad.haskellPackages = pkgs.haskell.packages.ghc822;
      windowManager.default = "xmonad";
    };
    sshd.enable = true;
  };

  fonts = {
    fontconfig.enable = true;
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      tewi-font
      corefonts
      dejavu_fonts
      fira-code
      source-han-sans-japanese
      ubuntu_font_family
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraGroups.ngyj.gid = 1000;
  users.extraGroups.aigis.gid = 1001;
  users.extraUsers = {
    ngyj = {
      createHome = true;
      home = "/home/ngyj";
      description = "namigyj";
      group = "ngyj";
      extraGroups = [ "wheel" "audio" "video" "networkmanager" "disk" "aigis" "wireshark" "sway"];
      isNormalUser = true;
      uid = 1000;
    };

    aigis = {
      createHome = true;
      home = "/home/aigis";
      description = "Aigis";
      group = "aigis";
      uid = 1001;
    };
  };

  nixpkgs.config = {
    pulseaudio = true;
    allowUnfree = true;
  };

  nix = {
    package = pkgs.nixUnstable;
    trustedBinaryCaches = [ "http://cache.nixos.org" ];
    binaryCaches = [ "http://cache.nixos.org" ];
    maxJobs = pkgs.stdenv.lib.mkForce 4;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    binutils
    cabal2nix
    emacs
    feh
    firefox-devedition-bin
    git
    haskellPackages.hlint
    haskellPackages.hpack
    haskellPackages.xmobar
    htop
    jpegoptim
    mpv
    networkmanager
    nitrogen
    nix-bash-completions
    ntfs3g
    optipng
    p7zip
    pavucontrol
    psmisc
    racket
    ripgrep
    rofi
    rxvt_unicode
    scrot
    unzip
    vim
    # vimus
    wget
    which
    xlibs.xsetroot
    xscreensaver
    zathura
    zip
  ];

  nix.gc.automatic = true;
}
