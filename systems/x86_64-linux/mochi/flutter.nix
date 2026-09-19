{ pkgs, ...}:

{
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      glibc
      libcxx
      libpulseaudio
      libtiff
      libuuid
      zlib
      libbsd
      ncurses5
      libdrm
      stdenv.cc.cc
      expat
      freetype
      nss
      nspr
      alsa-lib
      waylandpp.lib
      libgbm
      libx11
      libxext
      libxdamage
      libxfixes
      libxcb
      libxcomposite
      libxcursor
      libxi
      libxrender
      libxtst
      libice
      libsm
      libxkbfile
      libxshmfence
    ];
  };
  environment.systemPackages = with pkgs; [
    android-studio-full
    flutterPackages.stable
    jdk17
    unzip
  ];
}
