{ pkgs, ...}:

{
  programs.nix-ld = {
    enable = true;
    libraries = [
      pkgs.libx11
    ];
  };
  environment.systemPackages = with pkgs; [
    android-studio-full
    flutterPackages.stable
    jdk17
    unzip
  ];
}
