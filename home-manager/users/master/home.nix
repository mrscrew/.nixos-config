{ pkgs, ... }: {
  # Импорт конфигураций
  imports = [
    ./zsh.nix          # Настройки Zsh
    ./orca-slicer.nix   # Конфигурация OrcaSlicer
    ../../modules/bundle.nix  # Дополнительные модули
  ];

  # Основные настройки для пользователя
  home = {
    username = "master";             # Имя пользователя
    homeDirectory = "/home/master";  # Путь к домашней директории пользователя
    stateVersion = "24.05";          # Версия состояния для обратной совместимости
  };
}