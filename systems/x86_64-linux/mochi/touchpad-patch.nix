{pkgs, lib, config, ...}:

let
  touchpadPatch = config.boot.kernelPackages.callPackage ./touchpad-module.nix { };
in
{
  boot.extraModulePackages = [(lib.hiPrio touchpadPatch)];
}
