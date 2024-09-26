{ pkgs, ... }: {
  # Импорт конфигураций
  imports = [
    ./zsh.nix # Настройки Zsh
    ../../modules/bundle.nix # Дополнительные модули
  ];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "yandex-browser-stable-24.7.1.1120-1"
    ];
  };

  # Основные настройки для пользователя
  home = {
    username = "master"; # Имя пользователя
    homeDirectory = "/home/master"; # Путь к домашней директории пользователя
    stateVersion = "24.05"; # Версия состояния для обратной совместимости
    file = {
      "background.jpg".source = ./background.jpg; # Добавление background.jpg в домашнюю директорию
      "avatar.jpg".source = ./avatar.jpg; # Добавление avatar.jpg в домашнюю директорию
    };
    packages = with pkgs; [
      orcaslicer.i18n.ru-RU
    ];
  };
}
