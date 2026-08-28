{ pkgs, ... }:
{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
        vhostUserPackages = with pkgs; [ virtiofsd ];
      };
      allowedBridges = [
        "virbr0"
      ];
    };
    spiceUSBRedirection.enable = true;
  };

  networking = {
    firewall = {
      interfaces."virbr0" = {
        allowedUDPPorts = [
          53
          67
          68
        ];
        allowedTCPPorts = [ 53 ];
      };
      trustedInterfaces = [
        "virbr0"
      ];
    };
    nat = {
      enable = true;
      internalInterfaces = [
        "virbr0"
      ];
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    swtpm
    dnsmasq
  ];
}
