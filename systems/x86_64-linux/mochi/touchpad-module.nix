{
  kernel,
  fetchpatch,
}:

let
  modulel = "i2c";
in
kernel.stdenv.mkDerivation {
  pname = baseNameOf module;
  inherit (kernel) version src;

  patches = [ ./touchpad.patch ];

  nativeBuildInputs = kernel.moduleBuildDependencies;

  enableParallelBuild = true;

  buildPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      M=$(pwd)/${module} \
      modules
  '';

  installPhase = ''
    make -C ${kernel.dev}/lib/modules/${kernel.modDirVersion}/build \
      INSTALL_MOD_PATH=$out \
      INSTALL_MOD_DIR=kernel/${module} \
      modules_install
  '';
}
