{ pkgs, ...}:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      libx11
      libpulseaudio
      gperftools
    ];
  };
  environment.systemPackages = with pkgs; [
    android-studio-full
    flutterPackages.stable
    jdk17
    unzip
  ];
}
