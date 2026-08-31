{
  # Модуль настройки загрузчика GRUB.
  # Настраивает UEFI-загрузку с EFI-разделом на /boot/efi и включает определение других ОС (OS Prober).
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
    };
    timeout = 1;
  };
}
