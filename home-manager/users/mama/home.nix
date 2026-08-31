{ pkgs, inputs, ... }: {
  # Импорт конфигураций пользователя
  imports = [
    ./zsh.nix                   # Настройки Zsh
    ../../modules/cursor.nix    # Тема курсора
    ../../modules/yandex-browser/default.nix   # Яндекс.Браузер (последняя версия)
    inputs.noctalia.homeModules.default   # Модуль Noctalia (десктоп-шелл)
  ];

  # Разрешение несвободных пакетов и небезопасной версии Яндекс.Браузера
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "yandex-browser-stable-26.6.1.1083-1"
    ];
  };

  # Noctalia — десктоп-шелл поверх композитора Niri
  programs.noctalia = {
    enable = true;
    settings = {
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
    };
  };

  # Niri — композитор Wayland
  programs.niri = {
    enable = true;
  };

  # Основные настройки для пользователя
  home = {
    username = "mama";                    # Имя пользователя
    homeDirectory = "/home/mama";         # Домашняя директория
    stateVersion = "26.05";               # Версия состояния (обновлено до 26.05)

    # Единственное разрешённое графическое приложение (Яндекс.Браузер — из модуля)
    packages = with pkgs; [
      vscode-with-extensions
    ];
  };
}