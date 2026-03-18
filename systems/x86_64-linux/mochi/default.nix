


{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./flatpak.nix
      ./podmanconfig.nix
      ./hardware-bluetooth-conf.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  systemd.services."mute-led-disable" = {
    unitConfig = {
      Description="Disables the annoying mute light on keyboard";
      After="multi-user.target";
    };
    serviceConfig={
	ExecStart="${pkgs.coreutils}/bin/echo 'off' > /sys/class/sound/ctl-led/mic/mode";
        Type="simple";
    };
    wantedBy = ["graphical.target"];
  };
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;
  # Enable XWayland
  programs.xwayland.enable = true;

  #Enable kde_connect
  programs.kdeconnect.enable = true;

  #MySQL aktivieren
  services.mysql = {
    enable = true;
    package = pkgs.mysql80;
  };

  #Lid Switch Manuell einstellen
  services.logind = {
  lidSwitch = "suspend";
  lidSwitchOnExternalPower = "suspend";
  };


  # Configure console keymap
  console.keyMap = "de";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.lina = {
    isNormalUser = true;
    description = "Lina";
    extraGroups = [ "networkmanager" "wheel" ];
  };


  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;


  environment.systemPackages = with pkgs; [
    # other stuff
    git
    mysql-workbench
    android-tools #fuer android studio
    nextcloud-client
    # spelling
    aspellDicts.de
    aspellDicts.en
    aspellDicts.en-science
    aspellDicts.en-computers

    # Cattpuccin
     #(catppuccin-papirus-folders.override {
     #  flavor = "latte";
     #  accent = "peach";
     #})
     (catppuccin-papirus-folders.override {
       flavor = "mocha";
       accent = "peach";
     })
     # KDE Themes
     (catppuccin-kde.override {
       flavour = [ "mocha" "latte" ];
       accents = [ "peach" ];
       winDecStyles = [ "modern" ];
     })
     (catppuccin-sddm.override {
       flavor = "mocha";
     })
     # GTK Themes
     (catppuccin-gtk.override {
       variant = "mocha";
       accents = [ "peach" ];
     })
     (catppuccin-gtk.override {
       variant = "latte";
       accents = [ "peach" ];
     })
     catppuccin-cursors.lattePeach
     catppuccin-cursors.mochaPeach
  ];

  programs.neovim.enable = true;
  programs.zsh.enable = true;

  # nix config
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # GPU
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];
  };

  system.stateVersion = "26.05";
}
