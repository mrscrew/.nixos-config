{
  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi"; # ← use the same mount point here.
    };
    grub = {
      enable=true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    timeout = 1;
  };
}
