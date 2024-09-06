{ pkgs, ... }:
{
  nixpkgs.config = {
    allowUnfree = true;
  };

  services.gnome.gnome-settings-daemon.enable = true; # Дает возможность управления настройками GNOME на уровне системы
  services.openssh.enable = true; # Включаем OpenSSH

  programs.kdeconnect = {
    enable = true; # Включаем KDE Connect
    package = pkgs.gnomeExtensions.gsconnect; # Гном версия KDE Connect
  };

  programs.firefox.enable = true; # Устанавливаем Firefox

  environment.systemPackages = with pkgs; [
    # Графические редакторы
    evince # Просмотрщик документов
    cheese # Инструмент для веб-камеры
    freecad # 3D CAD модельный инструмент
    gimp # Редактор растровой графики (возможно добавить, если требуется)
    gnome-photos # Просмотр изображений
    gnome-terminal # Терминал GNOME
    gnome-tweaks # Настройка GNOME

    # Мультимедиа
    ffmpeg # Мультимедийный фреймворк
    gnome-music # Музыкальный плеер GNOME
    gnome-music # Музыкальный плеер GNOME
    mpv # Мультимедийный плеер (возможно добавить, если требуется)
    totem # Видеоплеер GNOME
    vlc # Мультимедийный плеер VLC

    # Офисные приложения
    libreoffice-qt6-fresh # Офисный пакет LibreOffice

    # Утилиты
    bluez # Поддержка Bluetooth
    bluez-tools # Утилиты для Bluetooth
    dconf-editor # Редактор настроек Dconf
    file # Утилита для работы с файлами
    git # Система управления версиями
    htop # Мониторинг процессов
    nano # Текстовый редактор (возможно добавить, если требуется)
    ntfs3g # Поддержка NTFS
    scrot # Скриншотер
    unzip # Распаковка ZIP-архивов
    wget # Командная утилита для загрузки файлов в интернете
    zram-generator # Генерация сжатых блочных устройств

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

    # Темы и иконки
    numix-gtk-theme # GTK-тема Numix
    numix-icon-theme # Тема иконок Numix
    numix-icon-theme-circle # Круглая тема иконок Numix
    numix-cursor-theme # Тема курсора Numix

    # Установка звуковых систем
    pipewire # Звуковая система PipeWire
    pulseaudio # Звуковая система PulseAudio

    # Другие утилиты
    home-manager # Управление конфигурацией

    # Гном расширения   
    gnomeExtensions.settingscenter # Центр настроек GNOME
    gnomeExtensions.appindicator # Индикатор приложений GNOME
    gnomeExtensions.gsconnect # GNOME версия KDE Connect
  ];

  # Шрифты
  fonts.packages = with pkgs; [
    noto-fonts # Шрифты Noto
    noto-fonts-emoji # Эмодзи шрифты Noto
  ];
}
