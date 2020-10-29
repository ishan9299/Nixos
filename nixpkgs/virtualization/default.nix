{ config, pkgs, ... }:
{
  # Virtualization
  virtualisation.kvmgt.enable = true;
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuRunAsRoot = false;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  environment.systemPackages = with pkgs; [virt-manager];
}
