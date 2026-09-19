{ pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    android-studio-full
    flutterPackages.stable
    jdk17
    unzip
  ];
}
