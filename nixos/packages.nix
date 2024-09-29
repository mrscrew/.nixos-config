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
    gimp # Редактор растровой графики (возможно добавить, если требуется)

    # Мультимедиа
    cheese # Инструмент для веб-камеры
    ffmpeg_7 # Мультимедийный фреймворк
    gnome-music # Музыкальный плеер GNOME
    gnome-photos # Просмотр изображений
    gnome-terminal # Терминал GNOME
    gnome-tweaks # Настройка GNOME
    totem # Видеоплеер GNOME
    vlc # Мультимедийный плеер VLC

    # Офисные приложения
    evince # Просмотрщик документов
    libreoffice-qt6-fresh # Офисный пакет LibreOffice

    # Утилиты
    bluez # Поддержка Bluetooth
    bluez-tools # Утилиты для работы с Bluetooth
    dconf-editor # Редактор настроек Dconf
    file # Утилита для определения типа файлов
    git # Система управления версиями
    htop # Мониторинг процессов
    lshw
    nano # Текстовый редактор
    ntfs3g # Поддержка NTFS
    scrot # Утилита для создания скриншотов
    tree # Вывод структуры каталогов
    unzip # Утилита для распаковки ZIP-архивов
    wget # Утилита для загрузки файлов из интернета
    zram-generator # Генерация сжатых блочных устройств

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
