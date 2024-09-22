{ pkgs, ... }: {
  # Импорт конфигураций
  imports = [
    ./zsh.nix                 # Настройки Zsh
    ../../modules/bundle.nix  # Дополнительные модули
  ];

  # Основные настройки для пользователя
  home = {
    username = "master";             # Имя пользователя
    homeDirectory = "/home/master";  # Путь к домашней директории пользователя
    stateVersion = "24.05";          # Версия состояния для обратной совместимости
    file = {
      "background.jpg".source = ./background.jpg;  # Добавление background.jpg в домашнюю директорию
      "/var/lib/AccountsService/icons/master".source = ./avatar.jpg;  # Меняю avatar
    };
  };
}