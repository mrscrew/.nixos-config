{ pkgs, ... }: {
  # Импорт конфигураций
  imports = [
    ./zsh.nix                 # Настройки Zsh
    ../../modules/cursor.nix  # Дополнительные модули
    ../../modules/qt.nix      # Настройки qt
  ];

  # Основные настройки для пользователя
  home = {
    username = "mama";             # Имя пользователя
    homeDirectory = "/home/mama";  # Путь к домашней директории пользователя
    stateVersion = "24.05";        # Версия состояния для обратной совместимости
  };
}