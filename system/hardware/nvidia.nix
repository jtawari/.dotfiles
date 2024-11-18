{lib, ...}: {
  # Configure Graphics
  hardware.graphics = {
    enable = true;
  };

  # Load Nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = ["nvidia"];

  # Allow only specific unfree packages
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "nvidia-settings"
    ];

  # Configure Nvidia
  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting = {
      enable = true;
    };
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      sync = {
        enable = true;
      };
    };
  };
}
