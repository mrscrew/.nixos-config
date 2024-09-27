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

  #nixpkgs.overlays = [ (import ../../modules/orca-slicer-overlay.nix) ];

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
      # Графические редакторы
      freecad # 3D CAD модельный инструмент
      openscad # Программируемый 3D CAD-моделлер

      # Интернет и коммуникация
      megasync # Синхронизация с облаком MEGA
      telegram-desktop # Мессенджер Telegram
      transmission_4-gtk # Торрент-клиент
      whatsapp-for-linux # Клиент WhatsApp

      # Пакеты для разработки
      git # Система управления версиями
      nixpkgs-fmt # Форматирование Nix конфигураций
      (vscode-with-extensions.override {
        vscodeExtensions = with vscode-extensions; [
          davidanson.vscode-markdownlint # Линтер для Markdown
          jnoortheen.nix-ide # Поддержка Nix в VS Code
          ms-azuretools.vscode-docker # Поддержка Docker
          ms-ceintl.vscode-language-pack-ru # Русский языковой пакет
          ms-python.python # Поддержка Python
          ms-vscode-remote.remote-ssh # Поддержка удаленного SSH
          redhat.vscode-yaml # Поддержка YAML
        ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          { name = "remote-ssh-edit"; publisher = "ms-vscode-remote"; version = "0.47.2"; sha256 = "1hp6gjh4xp2m1xlm1jsdzxw9d8frkiidhph6nvl24d0h8z34w49g"; }
        ];
      })

      # 3D-печать
      orca-slicer # Слайсер для 3D-печати
      prusa-slicer # Слайсер для 3D-печати

      # Дополнительные утилиты
      wineWowPackages.waylandFull # Wine с поддержкой 32/64-bit и Wayland
      winetricks # Настройка Wine
    ];
  };
}
