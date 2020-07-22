{config, pkgs, ...}:
{
  # overlays
  nixpkgs.overlays = [
    (self: super: {
      chromium = super.chromium.override {
        enableVaapi = true;
      };
    })
  ];
}
