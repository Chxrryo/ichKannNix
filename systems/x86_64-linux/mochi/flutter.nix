{ pkgs, ...}:

{
  programs.nix-ld.enable = true;
  environment.systemPackages = with pkgs; [
    android-studio-full
    flutterPackages.stable
    jdk17
    unzip
  ];
}
