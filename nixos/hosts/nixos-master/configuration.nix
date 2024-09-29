{ inputs, ... }: {
  # Импорт аппаратной конфигурации и дополнительных модулей
  imports = [
    ./hardware-configuration.nix
    ../../packages.nix
    ../../modules/nixos-master-users.nix
    ../../modules/bundle.nix
  ];

  # Определение имени хоста
  networking.hostName = "nixos-master";

  # Установка часового пояса
  time.timeZone = "Europe/Moscow";

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

  # Разрешение сборки пакетов с несвободными лицензиями
  nixpkgs.config = { allowUnfree = true; };

  # Версия состояния системы, используемая для обратной совместимости
  system.stateVersion = "24.05";
}
