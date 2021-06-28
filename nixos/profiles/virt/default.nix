{ pkgs, ... }:
{
  # Virtualization
  virtualisation.kvmgt.enable = true;
  virtualisation.kvmgt.vgpus = {
    "i915-GVTg_V5_4" = {
      uuid = [ "e810578e-8cb1-11eb-8bdb-739efd526279" ];
    };
  };
  virtualisation.libvirtd = {
    enable = true;
    qemuOvmf = true;
    qemuRunAsRoot = true;
    onBoot = "ignore";
    onShutdown = "shutdown";
  };

  environment.systemPackages = with pkgs; [
    virt-manager
    looking-glass-client
    scream
  ];

  boot.kernelModules = [
    "kvmgt"
    "vfio-iommu-type1"
    "vfio-mdev"
    "vfio_pci"
    "vfio"
    "vfio_virqfd"
  ];

  boot.kernelParams = [
    "i915.enable_gvt=1"
    "kvm.ignore_msrs=1"
    "intel_iommu=on"
  ];

  boot.extraModprobeConfig = "
  options vfio-pci ids=10de:134e
  ";

  users.users.me = {
    extraGroups = [ "kvm" "libvirtd" ];
  };
}
