{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [
      (modulesPath + "/installer/scan/not-detected.nix") # Импорт модуля для сканирования недетектированных устройств
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "uas" "usbhid" "sd_mod" "sdhci_pci" ]; # Доступные модули ядра для инициализации RAM-диска
  boot.initrd.kernelModules = [ ]; # Модули ядра для инициализации RAM-диска
  boot.kernelModules = [ "kvm-intel" ]; # Поддержка виртуализации Intel
  boot.extraModulePackages = [ ]; # Дополнительные пакеты модулей ядра

  fileSystems = {
    "/" =
      {
        device = "/dev/disk/by-partlabel/nixos"; # UUID корневой файловой системы
        fsType = "ext4"; # Тип файловой системы
      };
    "/boot/efi" =
      {
        device = "/dev/disk/by-partlabel/boot"; # UUID EFI-раздела
        fsType = "vfat"; # Тип файловой системы EFI
        options = [ "fmask=0022" "dmask=0022" ]; # Параметры масок для прав доступа
      };
    "/home" =
      {
        device = "/dev/disk/by-partlabel/home"; # UUID раздела Home
        fsType = "ext4"; # Тип файловой системы
      };
  };
  swapDevices = [
    {
      device = "/dev/disk/by-partlabel/swap";
    }
  ]; # Определение устройств подкачки
  boot.resumeDevice = "/dev/disk/by-partlabel/swap";
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=1s
  '';


  networking.useDHCP = lib.mkDefault true; # Включить DHCP для всех интерфейсов
  # networking.interfaces.enp0s25.useDHCP = lib.mkDefault true; # Включить DHCP для конкретного интерфейса (закомментировано)
  # networking.interfaces.wlo1.useDHCP = lib.mkDefault true; # Включить DHCP для беспроводного интерфейса (закомментировано)

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux"; # Платформа хоста для Nixpkgs
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware; # Обновление микрокода Intel
  hardware.graphics = {
    enable = true; # Включить поддержку графики
    extraPackages = with pkgs; [
      vpl-gpu-rt # Драйверы для новых GPU на NixOS >24.05 или unstable
      # onevpl-intel-gpu  # Драйверы для новых GPU на NixOS <= 24.05 (закомментировано)
      # intel-media-sdk   # Драйверы для старых GPU (закомментировано)
    ];
  };
}
