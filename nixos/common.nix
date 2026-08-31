{ config, lib, pkgs, ... }: {
  # Общие настройки, одинаковые для всех хостов.
  # Здесь НЕ затрагиваются fileSystems и swapDevices — они специфичны для каждого хоста.

  # Целевой target для systemd: graphical.target запускает greetd (графический вход).
  # Без этого система загружается в multi-user.target (консоль).
  boot.target = "graphical.target";

  # Часовой пояс
  time.timeZone = "Europe/Moscow";
  time.hardwareClockInLocalTime = true;

  # Локализация и языковые настройки
  i18n = {
    defaultLocale = "ru_RU.UTF-8";
    supportedLocales = [ "ru_RU.UTF-8/UTF-8" ];
    extraLocaleSettings = {
      LC_ADDRESS = "ru_RU.UTF-8";
      LC_IDENTIFICATION = "ru_RU.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "ru_RU.UTF-8";
      LC_NAME = "ru_RU.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "ru_RU.UTF-8";
      LC_TIME = "ru_RU.UTF-8";
      LC_ALL = "ru_RU.UTF-8";
    };
  };

  # Отключение пароля для root
  users.users.root.hashedPassword = "!";

  # Автоматическая очистка системы (garbage collection) каждую неделю
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Автоматическая оптимизация хранилища Nix
  nix.settings.auto-optimise-store = true;

  # Включение экспериментальных функций (flakes)
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Бинарный кэш Noctalia (Cachix) для ускорения сборок
  nix.settings = {
    extra-substituters = [ "https://noctalia.cachix.org" ];
    extra-trusted-public-keys = [
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
    ];
  };

  # Разрешение сборки несвободных пакетов
  nixpkgs.config = { allowUnfree = true; };

  # Polkit — управление разрешениями для системных сервисов (нужен для GUI-уведомлений)
  services.polkit.enable = true;

  # AccountsService — нужен для greetd / Noctalia Greeter (показывает имена пользователей)
  services.accounts-daemon.enable = true;

  # Версия состояния системы (оставляем как было при первом развёртывании)
  system.stateVersion = "24.05";
}