{ pkgs, inputs, ... }: {
  # Импорт конфигураций пользователя master
  # Включает Zsh, Git, htop, курсор, браузер, VS Code и Noctalia
  imports = [
    ./zsh.nix                   # Настройки Zsh (уникальные алиасы)
    ../../modules/zsh/common.nix   # Общая конфигурация Zsh
    ../../modules/git.nix       # Настройки Git
    ../../modules/htop.nix      # Настройки htop
    ../../modules/cursor.nix    # Тема курсора
    ../../modules/yandex-browser/default.nix   # Яндекс.Браузер (последняя версия)
    ../../modules/vscode.nix    # VS Code с расширениями
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
      wallpaper = {
        enabled = true;
        default.path = "/home/master/background.jpg";
      };
    };
  };

  # Niri — композитор Wayland (скроллящийся тайлинг)
  programs.niri = {
    enable = true;
  };

  # Основные настройки для пользователя
  home = {
    username = "master";                    # Имя пользователя
    homeDirectory = "/home/master";         # Домашняя директория
    stateVersion = "26.05";                 # Версия состояния (обновлено до 26.05)

    # Файлы в домашней директории
    file = {
      "background.jpg".source = ./background.jpg;
      "avatar.jpg".source = ./avatar.jpg;
    };

    # Графические приложения (единственные разрешённые; Яндекс.Браузер — из модуля)
    # VS Code вынесен в отдельный модуль vscode.nix
    packages = with pkgs; [
      # Дополнительные пакеты при необходимости
    ];
  };
}
