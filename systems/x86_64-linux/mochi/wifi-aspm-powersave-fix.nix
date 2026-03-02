
#Habe es noch nirgends eingebaut

{ config, pkgs, ... }:


{

  networking.networkmanager.wifi.powersave = false;
  boot.kernelParams = [ "pcie_aspm=off" ];


}

