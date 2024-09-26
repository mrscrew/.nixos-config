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
    freecad # 3D CAD модельный инструмент
    gimp # Редактор растровой графики (возможно добавить, если требуется)

    # Мультимедиа
    cheese # Инструмент для веб-камеры
    ffmpeg # Мультимедийный фреймворк
    gnome-music # Музыкальный плеер GNOME
    gnome-photos # Просмотр изображений
    gnome-terminal # Терминал GNOME
    gnome-tweaks # Настройка GNOME
    mpv # Мультимедийный плеер (возможно добавить, если требуется)
    totem # Видеоплеер GNOME
    vlc # Мультимедийный плеер VLC

    # Офисные приложения
    evince # Просмотрщик документов
    libreoffice-qt6-fresh # Офисный пакет LibreOffice
    megasync # Клиент для синхронизации с облаком MEGA

    # Интернет-приложения
    telegram-desktop # Клиент для Telegram
    transmission_4-gtk # Клиент для торрентов
    whatsapp-for-linux # Клиент для WhatsApp

    # Утилиты
    bluez # Поддержка Bluetooth
    bluez-tools # Утилиты для работы с Bluetooth
    dconf-editor # Редактор настроек Dconf
    file # Утилита для определения типа файлов
    git # Система управления версиями
    htop # Мониторинг процессов
    nano # Текстовый редактор
    ntfs3g # Поддержка NTFS
    scrot # Утилита для создания скриншотов
    tree # Вывод структуры каталогов
    unzip # Утилита для распаковки ZIP-архивов
    wget # Утилита для загрузки файлов из интернета
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

    qt5ct # Утилита для управления темами Qt5
    adwaita-qt # Тема Adwaita
    materia-theme # Тема Materia

    # Установка звуковых систем
    pipewire # Звуковая система PipeWire
    pulseaudio # Звуковая система PulseAudio

    # Другие утилиты
    home-manager # Управление конфигурацией
    wineWowPackages.waylandFull # Пакет Wine с поддержкой WoW64 и Wayland
    winetricks # Утилита для управления настройками Wine

    # Расширения GNOME
    gnomeExtensions.appindicator # Индикатор приложений GNOME
    gnomeExtensions.blur-my-shell # Размытие фона в GNOME
    gnomeExtensions.gsconnect # GNOME версия KDE Connect
    gnomeExtensions.settingscenter # Центр настроек GNOME
    gnomeExtensions.tophat # Расширение для дополнительной настройки

  ];

  # Шрифты
  fonts.packages = with pkgs; [
    noto-fonts # Шрифты Noto
    noto-fonts-emoji # Эмодзи шрифты Noto
  ];
}
