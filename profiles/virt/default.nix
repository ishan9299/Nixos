{ config, pkgs, ... }: {
  # Virtualization
  virtualisation.kvmgt.enable = true;
  # Remember to change this stuff when installing
  virtualisation.kvmgt.vgpus = {
    "i915-GVTg_V5_8" = {
      uuid = [ "bb22267c-8afd-11eb-82fb-9bb8bcf32991" ];
    };
  };
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuRunAsRoot = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    looking-glass-client
    scream-receivers
  ];
}
