{ inputs, lib, ... }: {
  # Модуль настройки десктопа Niri + Noctalia.
  # - Noctalia — нативный десктоп-шелл (бар, уведомления, контрольная панель);
  # - Noctalia Greeter — графический вход на основе greetd.
  # Сам композитор Niri настраивается на уровне Home Manager (programs.niri).
  #
  # ⚠️ ВНИМАНИЕ: Niri работает только на Intel GPU и AMD GPU (с open-source драйверами).
  # NVIDIA GPU НЕ поддерживается — нужны проприетарные драйверы, которые не работают
  # с Wayland-композиторами. Для NVIDIA используйте X11 (KDE/GNOME) или отключите Niri.

  imports = [
    inputs.noctalia.nixosModules.default
    inputs.noctalia-greeter.nixosModules.default
  ];

  # Noctalia — шелл поверх композитора Wayland
  programs.noctalia = {
    enable = true;
    # Включает NetworkManager, Bluetooth, UPower и сервис управления питанием
    recommendedServices.enable = true;
  };

  # Noctalia Greeter — входная сессия (включает greetd и accounts-daemon)
  programs.noctalia-greeter = {
    enable = true;
  };

  # Гарантируем требуемые Noctalia сервисы (подстраховка)
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}