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
  boot.kernel.sysctl = { "vm.dirty_bytes" = 2097152; "vm.dirty_background_bytes" = 2097152; }; # Для правильного отображения скорости при копировании
  boot.supportedFilesystems = [ "ntfs" ]; # Чтобы система видела файловую систему ntfs

  fileSystems = {
    "/" =
      {
        device = "/dev/disk/by-uuid/2989154e-0289-4c6b-a401-63fd358f719b";
        fsType = "btrfs";
        options = [ "subvol=@" ];
      };
    "/boot/efi" =
      {
        device = "/dev/disk/by-uuid/284B-4617";
        fsType = "vfat";
        options = [ "fmask=0022" "dmask=0022" ];
      };
    "/home" =
      {
        device = "/dev/disk/by-uuid/b8f7aab8-9604-4ec8-91a0-de7282961f88";
        fsType = "btrfs";
      };
  };
  swapDevices = [ ]; # Определение устройств подкачки

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
